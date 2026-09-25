import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_api/app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Advance time past SplashScreen's 2-second delay
    await tester.pump(const Duration(seconds: 3));
    expect(find.byType(MyApp), findsOneWidget);
  });
}
