import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recipe_app/main.dart' as app;
import 'package:recipe_app/src/ui/detailed_page/detailed_page_view.dart';
import 'package:recipe_app/src/ui/home_page/home_page_view.dart';
import 'package:recipe_app/src/ui/main_menu/main_page_view.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Main menu page should get load', (WidgetTester tester) async {
    //setup
    app.main();
    await tester.pumpAndSettle();
    //do
    await tester.pumpWidget(const MaterialApp(home: MainMenuPageView()));

    final drinkTile = find.byKey(const Key("drink"));
    await tester.tap(drinkTile);
    await tester.pumpAndSettle();
    await tester.pumpWidget(MaterialApp(
      home: HomePageView(selectedVal: 'drink'),
    ));

    await tester.pump(const Duration(milliseconds: 500));
    final drinkCatImg = find.widgetWithText(Column, "Cocktail").first;
    await tester.tap(drinkCatImg);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(milliseconds: 800));
    final foodItem = find.byKey(const Key("drink0")).first;
    await tester.pump(const Duration(milliseconds: 500));
    await tester.tap(foodItem);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 1000));
    await tester
        .pumpWidget(MaterialApp(
          home: DetailedPageView(
              selectedID: "11007", category: "drink", isSameSelectedID: false),
        ))
        .whenComplete(
            () async => await tester.pump(const Duration(milliseconds: 1000)));
    await tester.pumpAndSettle();
    // final drinkTile = find.byKey(const Key("drink"));
    // await tester.tap(drinkTile);
    // await tester.pumpAndSettle();
    // await tester.pumpWidget(MaterialApp(
    //   home: HomePageView(selectedVal: 'drink'),
    // ));
    //test
  });
}
