import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tp/Screens/login_screen.dart';
import 'package:tp/Screens/register_screen.dart';
import 'package:tp/texts.dart';

void main() {
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('Form validation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: RegisterScreen(),
    ));

    // Find the form widget
    final formFinder = find.byType(Form);
    expect(formFinder, findsOneWidget);

    // Find the text fields
    final firstNameFieldFinder =
        find.widgetWithText(TextFormField, 'First Name');
    final lastNameFieldFinder = find.widgetWithText(TextFormField, 'Last Name');
    final emailFieldFinder = find.widgetWithText(TextFormField, 'Email');
    final passwordFieldFinder = find.widgetWithText(TextFormField, 'Password');
    final repeatPasswordFieldFinder =
        find.widgetWithText(TextFormField, 'Repeat Password');

    // Enter empty values
    await tester.enterText(firstNameFieldFinder, '');
    await tester.enterText(lastNameFieldFinder, '');
    await tester.enterText(emailFieldFinder, 'invalid_email');
    await tester.enterText(passwordFieldFinder, '');
    await tester.enterText(repeatPasswordFieldFinder, '');
    final submitButtonFinder = find.widgetWithText(ElevatedButton, 'Register');
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();
    expect(find.text(fieldHint), findsWidgets);
    expect(find.text(emailHint), findsOneWidget);
    expect(find.text(notempty), findsOneWidget);

    // Enter valid values in the fields but not maching the repeat password
    await tester.enterText(firstNameFieldFinder, 'John');
    await tester.enterText(lastNameFieldFinder, 'Doedoe');
    await tester.enterText(emailFieldFinder, 'john.doe@example.com');
    await tester.enterText(passwordFieldFinder, 'aaaaaaaa1');
    await tester.enterText(repeatPasswordFieldFinder, 'aaaaaaaa2');
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();
    expect(find.text(emailHint), findsNothing);
    expect(find.text(fieldHint), findsNothing);
    expect(find.text(passwordHint), findsWidgets);
    expect(find.text(notmatch), findsOneWidget);

    // Enter valid values in the fields but password not valid
    await tester.enterText(firstNameFieldFinder, 'John');
    await tester.enterText(lastNameFieldFinder, 'Doedoe');
    await tester.enterText(emailFieldFinder, 'john.doe@example.com');
    await tester.enterText(passwordFieldFinder, 'a');
    await tester.enterText(repeatPasswordFieldFinder, 'b');
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();
    expect(find.text(emailHint), findsNothing);
    expect(find.text(fieldHint), findsNothing);
    expect(find.text(passwordHint), findsWidgets);
    expect(find.text(notmatch), findsNothing);
    // Enter valid values
    await tester.enterText(firstNameFieldFinder, 'John');
    await tester.enterText(lastNameFieldFinder, 'Doedoe');
    await tester.enterText(emailFieldFinder, 'john.doe@example.com');
    await tester.enterText(passwordFieldFinder, 'aaaaaaaa1');
    await tester.enterText(repeatPasswordFieldFinder, 'aaaaaaaa1');
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();
    expect(find.text(emailHint), findsNothing);
    expect(find.text(fieldHint), findsNothing);
    expect(find.text(notmatch), findsNothing);
    expect(find.text('Registered successfully'), findsOneWidget);
  });

  testWidgets('Login test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Find the email TextFormField
    final emailFieldFinder = find.widgetWithText(TextFormField, 'Email');
    expect(emailFieldFinder, findsOneWidget);

    // Find the password TextFormField
    final passwordFieldFinder = find.widgetWithText(TextFormField, 'Password');
    expect(passwordFieldFinder, findsOneWidget);

    // Enter valid email and password
    await tester.enterText(emailFieldFinder, 'a@cadot.eu');
    await tester.enterText(passwordFieldFinder, 'aaaaaaaa1');

    // Find the login button
    final loginButtonFinder = find.widgetWithText(ElevatedButton, 'Login');
    expect(loginButtonFinder, findsOneWidget);

    // Tap the login button
    await tester.tap(loginButtonFinder);
    await tester.pumpAndSettle();
    expect(find.text('Logged in successfully'), findsOneWidget);
  });
}
