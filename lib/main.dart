import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'services/mock_auth_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MockAuthService(),
      child: const PackWiseApp(),
    ),
  );
}
