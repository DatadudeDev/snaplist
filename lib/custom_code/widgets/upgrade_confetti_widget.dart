// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:confetti/confetti.dart';

class UpgradeConfettiWidget extends StatefulWidget {
  const UpgradeConfettiWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<UpgradeConfettiWidget> createState() => _UpgradeConfettiWidgetState();
}

class _UpgradeConfettiWidgetState extends State<UpgradeConfettiWidget> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 4));
  }

  @override
  void didUpdateWidget(covariant UpgradeConfettiWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (FFAppState().justUpgraded) {
      _controller.play();
      FFAppState().update(() {
        FFAppState().justUpgraded = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Properly release resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: _controller,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: false,
      colors: const [
        Colors.red,
        Colors.green,
        Colors.blue,
        Colors.yellow,
        Colors.purple,
        Colors.orange,
      ],
      child: Container(
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
