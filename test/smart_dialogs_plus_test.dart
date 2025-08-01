import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_progress_dialog/smart_progress_dialog.dart';

void main() {
  group('SmartProgressController Tests', () {
    late SmartProgressController controller;

    setUp(() {
      controller = SmartProgressController();
    });

    testWidgets('Attach and detach context', (WidgetTester tester) async {
      final testKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            key: testKey,
            builder: (context) {
              controller.attach(context);
              return const Placeholder();
            },
          ),
        ),
      );

      expect(() => controller.showLoading("Loading..."), returnsNormally);

      controller.detach();
      controller.showLoading("Should not throw");
    });

    testWidgets('Show and auto-dismiss success dialog',
        (WidgetTester tester) async {
      final controller = SmartProgressController();
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              controller.attach(context);
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.showSuccess(text: "Success!");
                    },
                    child: const Text('Show'),
                  ),
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump(); // Start dialog
      expect(find.text('Success!'), findsOneWidget);

      await tester.pump(const Duration(seconds: 4)); // wait for auto-dismiss
      expect(find.text('Success!'), findsNothing);
    });
  });
}
