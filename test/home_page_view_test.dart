import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:recipe_app/src/ui/home_page/home_page_view.dart';

@GenerateMocks([],
    customMocks: [MockSpec<NavigatorObserver>(returnNullOnMissingStub: true)])
void main() {
  group("Home page view testing", () {
    testWidgets("Check home page loaded successfully",
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        final mockObserver = MockNavigatorObserver();
        // final evenRoute = MaterialPageRoute(builder: (_) => Container());

        await tester.pumpWidget(MaterialApp(
            home: HomePageView(selectedVal: "food"),
            navigatorObservers: [mockObserver]));
        await tester.pumpAndSettle();
        expect(find.text("Good Morning Akila!"), findsOneWidget);
      });
    });
  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
