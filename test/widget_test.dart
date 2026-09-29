import 'package:flutter_test/flutter_test.dart';
import 'package:yumquick/app/app.dart';

void main() {
  testWidgets('YumQuickApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const YumQuickApp());

    // Verify that the login screen loads as the initial route.
    expect(find.text('Welcome Back!'), findsOneWidget);
  });
}