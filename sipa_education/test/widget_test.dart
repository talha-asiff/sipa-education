import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sipa_education/auth_gate.dart';
import 'package:sipa_education/courses_page.dart';
import 'package:sipa_education/login_page.dart';
import 'package:sipa_education/logic.dart';

void main() {
  setUp(() {
    registeredCourses.value = {};
  });

  testWidgets('login offers Google authentication only', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.byType(TextFormField), findsNothing);
    expect(find.text('Create an account'), findsNothing);
  });

  testWidgets('unauthenticated users cannot access protected content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AuthGate(
          child: const Text('Protected dashboard'),
          authStateChanges: Stream<User?>.value(null),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Protected dashboard'), findsNothing);
  });

  testWidgets('catalog registration updates the registered course map', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: CoursesPage()));
    await tester.tap(find.byKey(const ValueKey('register-course-biology')));
    await tester.pump();

    expect(registeredCourses.value.containsKey('biology'), isTrue);
    expect(find.text('Added'), findsOneWidget);
  });
}
