import 'package:flutter_test/flutter_test.dart';

import 'package:order_kiosk_app/main.dart';

void main() {
  testWidgets('renders app shell', (WidgetTester tester) async {
    await tester.pumpWidget(const OrderKioskApp());

    expect(find.text('Order Kiosk'), findsOneWidget);
  });
}
