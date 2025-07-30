import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_progress_dialog/smart_progress_dialog.dart';

void main() {
  late SmartProgressController controller;

  setUp(() {
    controller = SmartProgressController();
  });

  testWidgets('dismiss manually closes dialog', (tester) async {
    await tester.pumpWidget(TestApp(controller));

    // Show a dialog without auto-dismiss to avoid pending timers
    controller.showInfo(message: 'Info', autoDismiss: false);

    // Wait for the dialog to render
    await tester.pump();

    // Dialog should be visible
    expect(find.byType(SmartProgressDialog), findsOneWidget);
    expect(find.text('Info'), findsOneWidget);

    // Dismiss manually
    controller.dismiss();
    await tester.pumpAndSettle();

    // Dialog should no longer be visible
    expect(find.byType(SmartProgressDialog), findsNothing);
  });
}

/// Minimal test scaffold to attach controller
class TestApp extends StatelessWidget {
  final SmartProgressController controller;
  const TestApp(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          controller.attach(context);
          return const Scaffold(body: SizedBox());
        },
      ),
    );
  }
}
