import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/services/mock_auth_service.dart';
import 'add_trip_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<MockAuthService>(context, listen: false);
    final email = auth.currentUser?.email ?? 'user';
    return Scaffold(
      appBar: AppBar(
        title: const Text('PackWise'),
        actions: [
          IconButton(onPressed: () async {
            await auth.signOut();
          }, icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddTripPage())),
        child: const Icon(Icons.add),
      ),
      body: Center(child: Text('Welcome, $email\n\n(Trips will appear here after you add them)', textAlign: TextAlign.center)),
    );
  }
}
