import 'package:flutter/material.dart';

import 'app_navigation_actions.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
        actions: const [AppNavigationActions()],
      ),
      body: const Center(child: Text('Subscription')),
    );
  }
}
