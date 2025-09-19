import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/mock_auth_service.dart';
import 'screen/auth/homepage.dart';
import 'screen/auth/login_page.dart';

class PackWiseApp extends StatelessWidget {
  const PackWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PackWise (Demo)',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const Root(),
    );
  }
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<MockAuthService>(context);
    // Show a simple splash while initializing if you want. For now just check auth.
    if (auth.currentUser != null) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  }
}
