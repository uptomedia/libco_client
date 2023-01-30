// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('lilaapp', () {
    // Elements ...
    final deliver = find.byValueKey('deliver');
    final startupPhone = find.byValueKey('startupPhone');
    final SignInPass = find.byValueKey('SignInPass');
    final SignInButton = find.byValueKey('SignInButton');
    final enterIcon = find.byValueKey('enterIcon');
    final signUpPassword = find.byValueKey('signUpPassword');
    final signUpConfirmPassword = find.byValueKey('signUpConfirmPassword');
    final createAccount = find.byValueKey('createAccount');
    final activationCode = find.byValueKey('activationCode');

    //driver;
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver?.close();
    });
    test('SignIn Test', () async {
      await Future.delayed(Duration(seconds: 10));
      driver?.setTextEntryEmulation(enabled: true);
      await driver?.tap(deliver);
      await Future.delayed(Duration(seconds: 5));
      await driver?.tap(startupPhone);
      String Phone = '0937692249';
      await driver?.enterText(Phone);
      await driver?.tap(enterIcon);
      await Future.delayed(Duration(seconds: 2));
      await driver?.tap(SignInPass);
      await driver?.enterText('123123');
      await driver?.tap(SignInButton);
      // Use the `driver.getText` method to verify the counter starts at 0.
    });

    //  test('SignUp Test', () async {
    //  driver.setTextEntryEmulation(enabled:true);
    //   await driver.tap(deliver);
    //   await driver.tap(startupPhone);
    //   /*Random random = new Random();
    //   int randomNumber = random.nextInt(100);*/
    //   String Phone='093769227989';
    //   await driver.enterText(Phone);
    //   //expect(Phone,driver.get(startupPhone));
    //   await driver.tap(enterIcon);
    //   await Future.delayed(Duration(seconds: 2));
    //   await driver.tap(signUpPassword);
    //   await driver.enterText('123123');
    //   await driver.tap(signUpConfirmPassword);
    //   await driver.enterText('123123');
    //   await driver.tap(createAccount);
    //   await Future.delayed(Duration(seconds: 1));
    //   await driver.tap(activationCode);
    //   await driver.enterText('1111');
    //   await Future.delayed(Duration(seconds: 1));
    //    // Use the `driver.getText` method to verify the counter starts at 0.
    // });
  });
}
