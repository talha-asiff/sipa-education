import 'package:flutter_test/flutter_test.dart';

import 'package:cipa_international/main.dart';

void main() {
  testWidgets('Tabs open their empty placeholder pages', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('CIPA International'), findsOneWidget);
    expect(find.text('Home page'), findsOneWidget);

    await tester.tap(find.text('Courses'));
    await tester.pumpAndSettle();
    expect(find.text('Courses page'), findsOneWidget);
    expect(find.text('This page is empty for now.'), findsOneWidget);

    await tester.tap(find.text('Billing & Pricing'));
    await tester.pumpAndSettle();
    expect(find.text('Billing & Pricing page'), findsOneWidget);
  });
}
