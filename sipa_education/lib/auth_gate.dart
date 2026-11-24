import 'package:flutter/material.dart';

import 'login_page.dart';
import 'logic.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DemoUser?>(
      valueListenable: currentUser,
      builder: (context, user, _) => user == null ? const LoginPage() : child,
    );
  }
}
