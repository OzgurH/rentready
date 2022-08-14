// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:nock/nock.dart';

import 'package:rentready/main.dart';

void main() {
  // setUpAll(nock.init);

  // setUp(() {
  //   nock.cleanAll();
  // });
  testWidgets('Data visible on screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    final Finder searchtextfield = find.byKey(
      const Key(
        'searchtextfield',
      ),
    );
    expect(searchtextfield, findsOneWidget);

    final filterbutton = find.byKey(const Key('filterbutton'));
    expect(filterbutton, findsOneWidget);

    final view1button = find.byKey(const Key('view1button'));
    expect(view1button, findsOneWidget);

    final view2button = find.byKey(const Key('view2button'));
    expect(view2button, findsOneWidget);

    // Tap the 'view' icon and trigger a frame.
    await tester.tap(find.byKey(const Key('filterbutton')));
    await tester.pump();

    // Verify that filter screen.
    expect(find.text('State or Province'), findsOneWidget);
  });
}
