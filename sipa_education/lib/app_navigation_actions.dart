import 'package:flutter/material.dart';

class AppNavigationActions extends StatelessWidget {
  const AppNavigationActions({super.key});

  static const _actions = [
    (label: 'Home', route: '/home'),
    (label: 'Courses', route: '/courses'),
    (label: 'Subscription', route: '/subscription'),
    (label: 'Account', route: '/account'),
  ];

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width < 720) {
      return PopupMenuButton<String>(
        tooltip: 'Open navigation menu',
        icon: const Icon(Icons.menu_rounded),
        onSelected: (route) {
          Navigator.of(context).pushReplacementNamed(route);
        },
        itemBuilder: (context) => _actions
            .map(
              (action) => PopupMenuItem(
                value: action.route,
                child: Text(action.label),
              ),
            )
            .toList(),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _actions.map((action) {
        return TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(action.route);
          },
          style: TextButton.styleFrom(
            minimumSize: const Size(0, 40),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(action.label),
        );
      }).toList(),
    );
  }
}
