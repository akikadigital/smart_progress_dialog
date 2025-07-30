import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_progress_dialog/smart_progress_dialog.dart';

void main() {
  testWidgets('SmartListLoader is hidden when isLoading is false',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmartListLoader(isLoading: false),
        ),
      ),
    );

    // Should not find CircularProgressIndicator
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('SmartListLoader is visible when isLoading is true',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmartListLoader(isLoading: true),
        ),
      ),
    );

    // Should find one CircularProgressIndicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('SmartListLoader respects custom size and color', (tester) async {
    const testColor = Colors.red;
    const testSize = 48.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmartListLoader(
            isLoading: true,
            size: testSize,
            color: testColor,
          ),
        ),
      ),
    );

    final circular = tester.widget<CircularProgressIndicator>(
      find.byType(CircularProgressIndicator),
    );

    expect(circular.strokeWidth, 3.0);
    expect(
      (circular.valueColor as AlwaysStoppedAnimation).value,
      testColor,
    );

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(sizedBox.width, testSize);
    expect(sizedBox.height, testSize);
  });
}
