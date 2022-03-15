// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';

void main() {
  testWidgets("Food network image loaded", (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      await tester.pumpWidget(const CircleAvatar(
        backgroundImage: NetworkImage("https://picsum.photos/id/835/200/300"),
      ));
    });
  });
}
