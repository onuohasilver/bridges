import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';

class BridgeWidgetTest extends StatelessWidget {
  const BridgeWidgetTest({Key? key, required this.run}) : super(key: key);
  final ValueSetter<BridgeBase> run;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BridgeState>(
      create: (context) => BridgeState(),
      child: Builder(
        builder: (context) {
          BridgeBase bridge = Provider.of<BridgeBase>(context);

          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            run(bridge);
          });
          return const Placeholder();
        },
      ),
    );
  }
}
