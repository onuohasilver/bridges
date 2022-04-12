import 'package:bridges/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

BridgeBase bridge(BuildContext context) =>
    Provider.of<BridgeBase>(context, listen: false);
