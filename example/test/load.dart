import 'package:bridgestate/bridges.dart';
import 'package:flutter_test/flutter_test.dart';

load() {
  testWidgets(
    "Test Loading and Reading",
    (WidgetTester tester) async {
      tester.pumpWidget(
        BridgeWidgetTest(
          run: (bridge) {
            bridge.load('Test Variable', 2, int);
            int variable = bridge.read('Test Variable', 0).slice;
            expect(variable, 2);
          },
        ),
      );
    },
  );
}
