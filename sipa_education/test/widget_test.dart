import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sipa_education/logic.dart';
import 'package:sipa_education/main.dart';

void main() {
  setUp(() {
    registeredCourses.value = {};
  });

  testWidgets('registering a catalog course shows it on Home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('You have no registered courses yet.'), findsOneWidget);
    expect(find.text('Biology Crash Course'), findsNothing);

    await tester.tap(find.widgetWithText(TextButton, 'Courses'));
    await tester.pumpAndSettle();

    expect(find.text('Biology Crash Course'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Register').first);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(FilledButton, 'Registered'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'Home'));
    await tester.pumpAndSettle();

    expect(find.text('Biology Crash Course'), findsOneWidget);
    expect(find.text('Chemistry Crash Course'), findsNothing);
  });
}
