import 'package:flutter/material.dart';

typedef Course = ({String title, IconData icon});

const Map<String, Course> availableCourses = {
  'biology': (title: 'Biology Crash Course', icon: Icons.biotech),
  'chemistry': (title: 'Chemistry Crash Course', icon: Icons.science),
  'physics': (title: 'Physics Crash Course', icon: Icons.rocket_launch),
  'mathematics': (title: 'Mathematics Crash Course', icon: Icons.calculate),
};

final ValueNotifier<Map<String, Course>> registeredCourses =
    ValueNotifier({});

class DemoUser {
  const DemoUser({required this.name, required this.email});

  final String name;
  final String email;
}

final ValueNotifier<DemoUser?> currentUser = ValueNotifier(null);

void startDemoSession({required String email, String? name}) {
  final normalizedEmail = email.trim();
  final fallbackName = normalizedEmail.split('@').first;
  final normalizedName = name?.trim() ?? '';
  currentUser.value = DemoUser(
    name: normalizedName.isNotEmpty ? normalizedName : fallbackName,
    email: normalizedEmail,
  );
}

String? validateEmail(String? value) {
  final email = value?.trim() ?? '';
  if (email.isEmpty) return 'Enter your email address.';
  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
    return 'Enter a valid email address.';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.length < 8) {
    return 'Use at least 8 characters.';
  }
  return null;
}
