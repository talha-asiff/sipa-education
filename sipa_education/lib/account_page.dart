import 'package:flutter/material.dart';

import 'app_navigation_actions.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: const [AppNavigationActions()],
      ),
      body: const Center(child: Text('Account')),
    );
  }
}
