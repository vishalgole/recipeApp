import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:recipe_app/src/ui/home_page/home_page_view.dart';
import 'package:recipe_app/src/ui/main_menu/main_page_view.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

@GenerateMocks([],
    customMocks: [MockSpec<NavigatorObserver>(returnNullOnMissingStub: true)])
void main() {
  group("Main menu page ui test", () {
    setUpAll(() {
      HttpOverrides.global = null;
    });
    test("load food image", () async {
      final result =
          await Dio().getUri(Uri.parse("https://picsum.photos/id/835/200/300"));
      expect(result.statusCode, 200);
    });

    test("load beverages image", () async {
      final result =
          await Dio().getUri(Uri.parse("https://picsum.photos/id/431/200/300"));
      expect(result.statusCode, 200);
    });

    // test("call function abc", () {
    //   var mainClass = MainMenuPageView.
    // });

    testWidgets("on click of food navigate to homepage screen",
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        final mockObserver = MockNavigatorObserver();
        final evenRoute = MaterialPageRoute(builder: (_) => Container());
        await tester.pumpWidget(MaterialApp(
            home: const MainMenuPageView(),
            navigatorObservers: [mockObserver]));
        expect(find.byKey(const Key("food")), findsOneWidget);
        await tester.tap(find.byKey(const Key("food")));
        await tester.pumpAndSettle();

        verifyNever(mockObserver.didPush(evenRoute, any));
        expect(find.byType(HomePageView), findsOneWidget);
      });
    });

    testWidgets("on click of beverages navigate to homepage screen",
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        final mockObserver = MockNavigatorObserver();
        final evenRoute = MaterialPageRoute(builder: (_) => Container());
        await tester.pumpWidget(MaterialApp(
            home: const MainMenuPageView(),
            navigatorObservers: [mockObserver]));
        expect(find.byKey(const Key("drink")), findsOneWidget);
        await tester.tap(find.byKey(const Key("drink")));
        await tester.pumpAndSettle();

        verifyNever(mockObserver.didPush(evenRoute, any));
        expect(find.byType(HomePageView), findsOneWidget);
      });
    });
  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
