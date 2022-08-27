import 'dart:developer';

import 'package:bridgestate/state/bridge_controller.dart';
import 'package:flutter/material.dart';

class BridgeBuilder extends StatefulWidget {
  const BridgeBuilder(
      {Key? key,
      required this.controllers,
      required this.child,
      this.init = true,
      this.dispose = false,
      this.initMethods = const [],
      this.disposeMethods = const []})
      : super(key: key);
  final List<BridgeController> controllers;
  final bool init, dispose;
  final Widget child;
  final List<Function()> initMethods, disposeMethods;

  @override
  State<BridgeBuilder> createState() => _BridgeBuilderState();
}

class _BridgeBuilderState extends State<BridgeBuilder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.init) {
        for (BridgeController controller in widget.controllers) {
          controller.initialise();
        }
      }
      if (widget.initMethods.isNotEmpty) {
        log('Calling initMethods');
        for (Function() function in widget.initMethods) {
          function.call();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        return widget.child;
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.disposeMethods.isNotEmpty) {
        log('Calling disposeMethods');
        for (Function() function in widget.disposeMethods) {
          function.call();
        }
      }

      if (widget.dispose) {
        for (BridgeController controller in widget.controllers) {
          controller.dispose();
        }
      }
    });

    super.dispose();
  }
}
