import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_auth_service.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  final _pwdC = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<MockAuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Form(
                key: _formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const CircleAvatar(radius: 36, child: Icon(Icons.backpack, size: 36)),
                  const SizedBox(height: 12),
                  const Text('PackWise', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailC,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (v) => v == null || v.isEmpty ? 'Enter email' : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _pwdC,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (v) => v == null || v.length < 6 ? '6+ chars' : null,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading ? null : () async {
                        if (!_formKey.currentState!.validate()) return;
                        setState(()=>_loading=true);
                        try {
                          await auth.signIn(_emailC.text.trim(), _pwdC.text);
                          // on success, provider will notify and Root widget will show HomePage
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                        } finally {
                          if (mounted) setState(()=>_loading=false);
                        }
                      },
                      child: _loading ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text("Don't have an account?"),
                    TextButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignupPage())), child: const Text('Sign up'))
                  ])
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
