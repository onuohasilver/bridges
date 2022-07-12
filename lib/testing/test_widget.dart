import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';

class BridgeWidgetTest extends StatelessWidget {
  const BridgeWidgetTest({Key? key, required this.run}) : super(key: key);
  final ValueSetter<BridgeState> run;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BridgeState>(
      create: (context) => BridgeState(),
      child: Builder(
        builder: (context) {
          BridgeState bridge = Provider.of<BridgeState>(context);

          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            run(bridge);
          });
          return const Placeholder();
        },
      ),
    );
  }
}
