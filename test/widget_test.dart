import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tp/Screens/register_screen.dart';
import 'package:tp/texts.dart';

void main() {
  testWidgets('Form validation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

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
    await tester.enterText(lastNameFieldFinder, 'Doe');
    await tester.enterText(emailFieldFinder, 'john.doe@example.com');
    await tester.enterText(passwordFieldFinder, 'Password123');
    await tester.enterText(repeatPasswordFieldFinder, 'nomatch');
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();
    expect(find.text(emailHint), findsNothing);
    expect(find.text(fieldHint), findsNothing);
    expect(find.text(notmatch), findsOneWidget);

    // Enter valid values in the fields but password not valid
    await tester.enterText(firstNameFieldFinder, 'John');
    await tester.enterText(lastNameFieldFinder, 'Doe');
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
    await tester.enterText(lastNameFieldFinder, 'Doe');
    await tester.enterText(emailFieldFinder, 'john.doe@example.com');
    await tester.enterText(passwordFieldFinder, 'aaaaaaaa1');
    await tester.enterText(repeatPasswordFieldFinder, 'aaaaaaaa1');
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();
    expect(find.text(emailHint), findsNothing);
    expect(find.text(fieldHint), findsNothing);
    expect(find.text(passwordHint), findsNothing);
    expect(find.text(notmatch), findsNothing);
  });
}
