import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sipa_education/logic.dart';
import 'package:sipa_education/main.dart';

void main() {
  setUp(() {
    registeredCourses.value = {};
    currentUser.value = null;
  });

  testWidgets('login gates the dashboard and registered courses appear there', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Your learning'), findsNothing);

    await tester.enterText(
      find.byKey(const ValueKey('login-email')),
      'learner@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('login-password')),
      'learning123',
    );
    await tester.tap(find.byKey(const ValueKey('login-submit')));
    await tester.pumpAndSettle();

    expect(find.text('Your learning'), findsOneWidget);
    expect(find.text('Your learning journey starts here'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'Courses'));
    await tester.pumpAndSettle();

    expect(find.text('Biology Crash Course'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('register-course-biology')));
    await tester.pumpAndSettle();

    expect(find.text('Added'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'Home'));
    await tester.pumpAndSettle();

    expect(find.text('Biology Crash Course'), findsOneWidget);
    expect(find.text('Chemistry Crash Course'), findsNothing);

    await tester.tap(find.widgetWithText(TextButton, 'Subscription'));
    await tester.pumpAndSettle();
    expect(find.text('SIPA Plus'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'Account'));
    await tester.pumpAndSettle();
    expect(find.text('learner@example.com'), findsOneWidget);

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
  });

  testWidgets('sign-up creates a demo session and opens the dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byKey(const ValueKey('open-signup')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('signup-name')),
      'Sipa Learner',
    );
    await tester.enterText(
      find.byKey(const ValueKey('signup-email')),
      'newlearner@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('signup-password')),
      'learning123',
    );
    await tester.enterText(
      find.byKey(const ValueKey('signup-confirm-password')),
      'learning123',
    );
    await tester.ensureVisible(find.byKey(const ValueKey('signup-submit')));
    await tester.tap(find.byKey(const ValueKey('signup-submit')));
    await tester.pumpAndSettle();

    expect(find.text('Welcome back, Sipa Learner'), findsOneWidget);
  });
}
