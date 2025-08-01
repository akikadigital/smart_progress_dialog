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
          body: SmartProgressDialogWidget(
            state: SmartProgressState.loading,
            text: 'Loading...',
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
          body: SmartProgressDialogWidget(
            state: SmartProgressState.success,
            text: 'Success!',
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
          body: SmartProgressDialogWidget(
            state: SmartProgressState.warning,
            text: 'Warning!',
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
          body: SmartProgressDialogWidget(
            state: SmartProgressState.error,
            text: 'Error!',
          ),
        ),
      ),
    );

    expect(find.text('Error!'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
