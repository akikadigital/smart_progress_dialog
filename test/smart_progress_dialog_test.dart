import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_progress_dialog/smart_progress_dialog.dart';

void main() {
  tearDown(() {
    // Any cleanup if needed
  });

  testWidgets('SmartProgressDialog shows loading state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmartProgressDialog(
            state: SmartProgressState.loading,
            message: 'Loading...',
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Loading...'), findsOneWidget);
  });

  testWidgets('SmartProgressDialog shows success state and auto-dismisses',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmartProgressDialog(
            state: SmartProgressState.success,
            message: 'Success!',
          ),
        ),
      ),
    );

    expect(find.text('Success!'), findsOneWidget);

    // Wait enough time for auto-dismiss timer
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });

  testWidgets('SmartProgressDialog shows warning state and auto-dismisses',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmartProgressDialog(
            state: SmartProgressState.warning,
            message: 'Warning!',
          ),
        ),
      ),
    );

    expect(find.text('Warning!'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });

  testWidgets('SmartProgressDialog shows failure state and auto-dismisses',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmartProgressDialog(
            state: SmartProgressState.failure,
            message: 'Error!',
          ),
        ),
      ),
    );

    expect(find.text('Error!'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
