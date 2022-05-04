import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

BridgeState bridge(BuildContext context, {bool listen = true}) =>
    Provider.of<BridgeState>(context, listen: listen);
