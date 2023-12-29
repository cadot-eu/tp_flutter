import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tp/Screens/login_screen.dart';
import 'package:tp/Screens/register_screen.dart';
import 'package:tp/texts.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('RegisterScreen Tests', () {
    setUpAll(() {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    testGoldens('golden: initial state', (tester) async {
      await loadAppFonts();
      await tester.pumpWidget(const MaterialApp(
        home: RegisterScreen(),
      ));
      await screenMatchesGolden(tester, 'start');
    });

    testGoldens('golden: form validation with empty values', (tester) async {
      await loadAppFonts();
      await tester.pumpWidget(const MaterialApp(
        home: RegisterScreen(),
      ));

      final submitButtonFinder =
          find.widgetWithText(ElevatedButton, 'Register');
      await tester.tap(submitButtonFinder);
      await tester.pumpAndSettle();
      await screenMatchesGolden(tester, 'empty');
      expect(find.text(fieldHint), findsWidgets);
      expect(find.text(notempty), findsOneWidget);
    });

    testGoldens('golden: form validation with non-matching passwords',
        (tester) async {
      await loadAppFonts();
      await tester.pumpWidget(const MaterialApp(
        home: RegisterScreen(),
      ));

      final submitButtonFinder =
          find.widgetWithText(ElevatedButton, 'Register');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'First Name'), 'John');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Last Name'), 'Doedoe');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'john.doe@example.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'password1');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Repeat Password'), 'password2');

      await tester.tap(submitButtonFinder);
      await tester.pumpAndSettle();
      await screenMatchesGolden(tester, 'password');
      expect(find.text(emailHint), findsNothing);
      expect(find.text(fieldHint), findsNothing);
      expect(find.text(passwordHint), findsWidgets);
      expect(find.text(notmatch), findsOneWidget);
    });

    testGoldens('golden: form validation with invalid password',
        (tester) async {
      await loadAppFonts();
      await tester.pumpWidget(const MaterialApp(
        home: RegisterScreen(),
      ));

      final submitButtonFinder =
          find.widgetWithText(ElevatedButton, 'Register');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'First Name'), 'John');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Last Name'), 'Doedoe');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'john.doe@example.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'a');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Repeat Password'), 'a');

      await tester.tap(submitButtonFinder);
      await tester.pumpAndSettle();
      await screenMatchesGolden(tester, 'passwordnocorrect');

      expect(find.text(emailHint), findsNothing);
      expect(find.text(fieldHint), findsNothing);
      expect(find.text(passwordHint), findsWidgets);
      expect(find.text(notmatch), findsNothing);
    });

    testGoldens('golden: form validation with valid values', (tester) async {
      await loadAppFonts();
      await tester.pumpWidget(const MaterialApp(
        home: RegisterScreen(),
      ));

      final submitButtonFinder =
          find.widgetWithText(ElevatedButton, 'Register');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'First Name'), 'John');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Last Name'), 'Doedoe');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'john.doe@example.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'password1');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Repeat Password'), 'password1');

      await tester.tap(submitButtonFinder);
      await tester.pumpAndSettle(); // Wait for navigation transition to finish
      expect(find.text(emailHint), findsNothing);
      expect(find.text(fieldHint), findsNothing);
      expect(find.text(notmatch), findsNothing);
      //TODO: test sqlite make a error
    });
  });

  group('LoginScreen Tests', () {
    testGoldens('golden: login validation', (tester) async {
      await loadAppFonts();
      await tester.pumpWidget(const MaterialApp(
        home: LoginScreen(),
      ));

      final emailFieldFinder = find.widgetWithText(TextFormField, 'Email');
      final passwordFieldFinder =
          find.widgetWithText(TextFormField, 'Password');
      await tester.enterText(emailFieldFinder, 'a@cadot.eu');
      await tester.enterText(passwordFieldFinder, 'aaaaaaaa1');

      final loginButtonFinder = find.widgetWithText(ElevatedButton, 'Login');
      await tester.tap(loginButtonFinder);
      //TODO: test with sqlite make a error
    });
  });
}
