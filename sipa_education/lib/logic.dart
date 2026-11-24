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
