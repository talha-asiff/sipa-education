import 'package:cipa_international/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Dashboard shows O/A Level courses and sample video lessons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CipaApp());

    expect(tester.takeException(), isNull);
    expect(find.text('MONDAY, 16 NOVEMBER'), findsOneWidget);
    expect(find.textContaining('Ultimate Biology Course'), findsOneWidget);
    expect(find.text('Quick video lessons'), findsOneWidget);
    expect(find.text('Cell structure: the basics'), findsOneWidget);
  });

  testWidgets('Course search filters the catalog', (WidgetTester tester) async {
    await tester.pumpWidget(const CipaApp());

    await tester.tap(find.text('Courses').last);
    await tester.pumpAndSettle();
    expect(find.text('Your courses'), findsOneWidget);
    expect(find.text('Chemistry, Unlocked'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Biology');
    await tester.pumpAndSettle();

    expect(find.text('Ultimate Biology'), findsOneWidget);
    expect(find.text('Chemistry, Unlocked'), findsNothing);
  });

  testWidgets('A video lesson opens a sample preview', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CipaApp());

    await tester.ensureVisible(find.text('WATCH LESSON'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('WATCH LESSON'));
    await tester.pumpAndSettle();

    expect(find.byType(VideoPreviewDialog), findsOneWidget);
    expect(find.text('CLOSE PREVIEW'), findsOneWidget);

    await tester.tap(find.text('CLOSE PREVIEW'));
    await tester.pumpAndSettle();
    expect(find.byType(VideoPreviewDialog), findsNothing);
  });

  testWidgets('Dashboard lays out on a phone-sized screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CipaApp());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Explore courses'), findsOneWidget);
  });
}
