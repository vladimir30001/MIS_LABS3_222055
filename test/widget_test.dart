import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mislab2/main.dart';

void main() {
  testWidgets('App loads categories screen', (WidgetTester tester) async {

    await tester.pumpWidget(const Mislab2App());


    expect(find.text('Categories'), findsOneWidget);


    await tester.pumpAndSettle();
  });
}
