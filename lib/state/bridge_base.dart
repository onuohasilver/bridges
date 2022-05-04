import 'package:bridges/state/bridge_state.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BridgeBase extends StatefulWidget {
  const BridgeBase({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<BridgeBase> createState() => _BridgeBaseState();
}

class _BridgeBaseState extends State<BridgeBase> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BridgeState>(
        create: (context) => BridgeState(), child: widget.child);
  }
}
