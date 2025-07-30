import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_progress_dialog/smart_progress_dialog.dart';

/// A simple app shell to test SmartSnackBar behavior
class TestApp extends StatelessWidget {
  final void Function(BuildContext) onShow;

  const TestApp({Key? key, required this.onShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => onShow(context),
              child: const Text('Show Snack bar'),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('SmartSnackBar shows overlay and auto dismisses', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: ElevatedButton(
                onPressed: () {
                  SmartSnackBar.show(
                    context,
                    'Test message',
                    title: 'Hello',
                    type: SmartSnackBarType.success,
                    position: SmartSnackBarPosition.bottom,
                    duration: SmartSnackBarDuration.short,
                  );
                },
                child: const Text('Show Snack bar'),
              ),
            ),
          ),
        ),
      ),
    );

    // Tap the button to show the snackbar
    await tester.tap(find.text('Show Snack bar'));
    await tester.pump(); // allow snackbar to build

    // Verify that the snackbar is shown
    expect(find.text('Test message'), findsOneWidget);
    expect(find.text('Hello'), findsOneWidget);

    // Wait for auto-dismiss duration
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(
        milliseconds: 100)); // extra time for dismissal animation

    // SnackBar should be gone
    expect(find.text('Test message'), findsNothing);
    expect(find.text('Hello'), findsNothing);
  });

  testWidgets('SmartSnackBar with close icon manually dismisses',
      (tester) async {
    await tester.pumpWidget(TestApp(
      onShow: (context) {
        SmartSnackBar.show(
          context,
          'Dismiss me!',
          title: 'Close Test',
          showCloseIcon: true,
          duration: SmartSnackBarDuration.indefinite,
        );
      },
    ));

    // Tap Show Snack bar button
    await tester.tap(find.text('Show Snack bar'));
    await tester.pumpAndSettle();

    // Wait to ensure snackbar overlay has rendered
    await tester.pump(const Duration(milliseconds: 500));

    // Tap the close icon
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // Verify it's removed
    expect(find.text('Dismiss me!'), findsNothing);
  });
}
