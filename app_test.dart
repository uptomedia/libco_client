import 'package:chegg/main.dart' as app;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  WidgetsFlutterBinding.ensureInitialized();
  testWidgets('tap on deliver', (WidgetTester tester) async {
    // Run app
    app.main();
    //await tester.pumpWidget(MyApp()); // Create main app
    await tester.pumpAndSettle(); // Finish animations and scheduled microtasks
    await tester.pump(Duration(seconds: 2)); // Wait some time
    // Enumerate all states that exist in the app just to show we can
    print("All states: ");
    tester.allStates.forEach((s) => print(s));
    // Find textFields
    final Finder deliver = find.byKey(ValueKey('keytest1'));
    final Finder startupPhone = find.byKey(ValueKey('startupPhone'));
    final Finder enterIcon = find.byKey(ValueKey('enterIcon'));
    final SignInPass = find.byKey(ValueKey('SignInPass'));
    final SignInButton = find.byKey(ValueKey('SignInButton'));
    // Ensure there is a login and password field on the initial page
    expect(deliver, findsOneWidget);
    await tester.pumpAndSettle();
    await tester.tap(deliver);
    await tester.pumpAndSettle(Duration(seconds: 10));
    await tester.tap(startupPhone);
    await tester.enterText(startupPhone, "0937692249");
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(enterIcon);
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.enterText(SignInPass, "123123");
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(SignInButton);
  });
}
