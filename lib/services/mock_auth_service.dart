import 'package:flutter/material.dart';

class MockUser {
  final String uid;
  final String email;
  MockUser({required this.uid, required this.email});
}

class MockAuthService extends ChangeNotifier {
  MockUser? _user;
  MockUser? get currentUser => _user;

  /// Simple sign-in: accepts test@example.com / password123
  Future<void> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate delay
    if (email == 'test@example.com' && password == 'password123') {
      _user = MockUser(uid: 'uid_test_1', email: email);
      notifyListeners();
    } else {
      throw Exception('Invalid credentials (use test@example.com / password123)');
    }
  }

  /// Simple sign-up: accepts any email/password and creates a mock user
  Future<void> signUp(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _user = MockUser(uid: DateTime.now().millisecondsSinceEpoch.toString(), email: email);
    notifyListeners();
  }

  Future<void> signOut() async {
    _user = null;
    notifyListeners();
  }
}
