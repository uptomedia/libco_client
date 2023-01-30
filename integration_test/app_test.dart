import 'package:chegg/core/testing/widget_test_keys.dart';
import 'package:chegg/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  WidgetsFlutterBinding.ensureInitialized();
  testWidgets('tap on login', (WidgetTester tester) async {
    // Run app
    app.main();
    //await tester.pumpWidget(MyApp()); // Create main app
    await tester.pumpAndSettle(); // Finish animations and scheduled microtasks
    await tester.pump(Duration(seconds: 2)); // Wait some time
    // Enumerate all states that exist in the app just to show we can
    print("All states: ");
    tester.allStates.forEach((s) => print(s));

    final Finder login = find.byKey(ValueKey(TEST_KEY_LOGIN_BUTTON));
    final Finder username = find.byKey(ValueKey(TEST_KEY_USERNAME));
    final Finder password = find.byKey(ValueKey(TEST_KEY_PASSWORD));

    await tester.enterText(username, "user");
    await tester.pumpAndSettle();

    await tester.enterText(password, "123456");
    await tester.pumpAndSettle();

    expect(login, findsOneWidget);

    tester.ensureVisible(login);
    await tester.tap(
      login,
    );

    await tester.pumpAndSettle(Duration(seconds: 5));
  });
}
