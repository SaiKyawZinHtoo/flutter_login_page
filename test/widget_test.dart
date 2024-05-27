// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:exercise_login_page/components/my_textfield.dart';
import 'package:exercise_login_page/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exercise_login_page/page/register_page.dart';
import 'package:exercise_login_page/page/home_page.dart';

void main() {
  testWidgets('LoginPage UI test', (WidgetTester tester) async {
    // Build the LoginPage widget
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(
        onTap: () {},
      ),
    ));

    // Verify that the welcome text is displayed
    expect(find.text('Welcome Back My Login Page'), findsOneWidget);

    // Verify that the email and password textfields are displayed
    expect(find.byType(TextField), findsNWidgets(2));

    // Interact with the text fields
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).last, 'password123');

    // Verify that the "Not a Member? Register Now" text is displayed
    expect(find.text('Not a Member?'), findsOneWidget);
    expect(find.text('Register Now'), findsOneWidget);
  });

  testWidgets('RegisterPage UI test', (WidgetTester tester) async {
    // Build the RegisterPage widget
    await tester.pumpWidget(MaterialApp(
      home: RegisterPage(
        onTap: () {},
      ),
    ));

    // 1. Verify UI Elements
    expect(find.byIcon(Icons.person_2_rounded), findsOneWidget);
    expect(find.text('Create Your Account Here?'), findsOneWidget);
    expect(
        find.byType(MyTextField), findsNWidgets(3)); // Verify all text fields
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Already have an account?'), findsOneWidget);
    expect(find.text('Login Now'), findsOneWidget);

    // 2. Interactions
    // Simulate entering text into text fields
    await tester.enterText(find.byType(MyTextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(MyTextField).at(1), 'password');

    // Tap the "Sign Up" button
    await tester.tap(find.text('Sign Up'));
  });

  testWidgets('HomePage UI test', (WidgetTester tester) async {
    // Build the HomePage widget
    await tester.pumpWidget(MaterialApp(
      home: HomePage(),
    ));

    // 1. Verify UI Elements
    expect(
        find.text('My Home Page Note'), findsOneWidget); // Verify app bar title
    expect(find.byIcon(Icons.logout), findsOneWidget); // Verify logout button
    expect(find.byType(ListView), findsOneWidget); // Verify list view
    expect(find.byType(FloatingActionButton), findsOneWidget); // Verify FAB

    // 2. Interactions
    // Tap the logout button
    await tester.tap(find.byIcon(Icons.logout));

    // Ensure that the user is navigated back to the login page or sign-in screen

    // Tap on an item in the list
    // await tester.tap(find.byType(ItemListTile).first); // Example: Tap on the first item
    // await tester.pumpAndSettle(); // Wait for navigation to item detail screen

    // Ensure that the item detail screen is displayed

    // Tap on the FAB
    await tester.tap(find.byType(FloatingActionButton));
  });
}
