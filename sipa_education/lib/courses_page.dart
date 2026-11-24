import 'package:flutter/material.dart';

import 'app_shell.dart';
import 'logic.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Course catalog',
      body: ValueListenableBuilder<Map<String, Course>>(
        valueListenable: registeredCourses,
        builder: (context, courses, _) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
            children: [
              Text(
                'Find your next course',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                'Add a course to see it on your dashboard.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              ...availableCourses.entries.map((entry) {
              final isRegistered = courses.containsKey(entry.key);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isCompact = constraints.maxWidth < 560;
                      final courseInfo = Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7EAF1),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Icon(
                              entry.value.icon,
                              color: const Color(0xFF780147),
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.value.title,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Add this course to your learning dashboard.',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                      final registerButton = FilledButton.icon(
                        key: ValueKey('register-course-${entry.key}'),
                        onPressed: isRegistered
                            ? null
                            : () {
                                registeredCourses.value = {
                                  ...registeredCourses.value,
                                  entry.key: entry.value,
                                };
                              },
                        icon: Icon(
                          isRegistered
                              ? Icons.check_rounded
                              : Icons.add_rounded,
                        ),
                        label: Text(isRegistered ? 'Added' : 'Register'),
                      );

                      return Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFECE4E9)),
                        ),
                        child: isCompact
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  courseInfo,
                                  const SizedBox(height: 14),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: registerButton,
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(child: courseInfo),
                                  const SizedBox(width: 16),
                                  registerButton,
                                ],
                              ),
                      );
                    },
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
