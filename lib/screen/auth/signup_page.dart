import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<MockAuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(children: [
            TextFormField(controller: _email, decoration: const InputDecoration(labelText: 'Email'), validator: (v)=> v==null||v.isEmpty?'Enter email':null),
            const SizedBox(height: 8),
            TextFormField(controller: _pwd, decoration: const InputDecoration(labelText: 'Password'), obscureText: true, validator: (v)=> v==null||v.length<6?'6+ chars':null),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading?null:() async {
                if (!_form.currentState!.validate()) return;
                setState(()=>_loading=true);
                try {
                  await auth.signUp(_email.text.trim(), _pwd.text);
                  Navigator.of(context).pop(); // sign up success -> back to login, Root will detect and show Home
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                } finally {
                  if (mounted) setState(()=>_loading=false);
                }
              },
              child: _loading ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Create account'),
            )
          ]),
        ),
      ),
    );
  }
}
