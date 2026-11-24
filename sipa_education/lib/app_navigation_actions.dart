import 'package:flutter/material.dart';

class AppNavigationActions extends StatelessWidget {
  const AppNavigationActions({super.key});

  static const _actions = [
    (label: 'Home', route: '/'),
    (label: 'Courses', route: '/courses'),
    (label: 'Subscription', route: '/subscription'),
    (label: 'Account', route: '/account'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _actions.map((action) {
        return TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(action.route);
          },
          style: TextButton.styleFrom(
            minimumSize: const Size(0, 40),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(action.label),
        );
      }).toList(),
    );
  }
}
