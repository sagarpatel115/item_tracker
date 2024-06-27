// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:item_tracker/main.dart';
import 'package:item_tracker/view/home_view.dart';

void main() {
  testWidgets('Flutter Widget Testing for web', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    //await tester.pumpWidget(const HomeView());


    var layout = find.byType(LayoutBuilder);
    expect(layout, findsOneWidget);
    //Act - Find button by type
    var eleBtn = find.byType(ElevatedButton);
    expect(eleBtn, findsOneWidget);

    //Act - Find button by type
    var textField = find.byType(TextFormField);

    //Assert - Check that exactly 2 Text input widgets are present
    expect(textField, findsNWidgets(2));

    var eleAddBtn = find.text("Add");
    expect(eleAddBtn, findsOneWidget);

    //Act - Find TextFormFields
    var NameField = find.byKey(const Key("NameKey"));
    var DescField = find.byKey(const Key("DescriptionKey"));

    expect(NameField, findsOneWidget);
    expect(DescField, findsOneWidget);

    //Fill text inputs
    await tester.enterText(NameField, "Item Name");
    await tester.enterText(DescField, "Item Description");

    //await tester.tap(fab);

    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
