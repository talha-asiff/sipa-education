import 'package:flutter/material.dart';

import 'app_navigation_actions.dart';
import 'logic.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: const [AppNavigationActions()],
      ),
      body: ValueListenableBuilder<Map<String, Course>>(
        valueListenable: registeredCourses,
        builder: (context, courses, _) {
          final catalog = availableCourses.entries.toList();
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: catalog.length,
            itemBuilder: (context, index) {
              final entry = catalog[index];
              final isRegistered = courses.containsKey(entry.key);

              return Card(
                child: ListTile(
                  leading: Icon(entry.value.icon),
                  title: Text(entry.value.title),
                  trailing: FilledButton(
                    onPressed: isRegistered
                        ? null
                        : () {
                            registeredCourses.value = {
                              ...registeredCourses.value,
                              entry.key: entry.value,
                            };
                          },
                    child: Text(isRegistered ? 'Registered' : 'Register'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
