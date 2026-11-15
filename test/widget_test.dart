import 'package:flutter_test/flutter_test.dart';

import 'package:cipa_international/main.dart';

void main() {
  testWidgets('Dashboard and placeholder tabs render without exceptions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(tester.takeException(), isNull);
    expect(find.text('CIPA International'), findsOneWidget);
    expect(find.text('Continue your'), findsOneWidget);
    expect(find.text('Ultimate Biology Course'), findsOneWidget);

    await tester.tap(find.text('Courses'));
    await tester.pumpAndSettle();
    expect(find.text('Courses page'), findsOneWidget);

    await tester.tap(find.text('Billing & Pricing'));
    await tester.pumpAndSettle();
    expect(find.text('Billing & Pricing page'), findsOneWidget);
  });
}
