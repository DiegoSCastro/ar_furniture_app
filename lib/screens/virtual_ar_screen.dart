import 'package:augmented_reality_plugin/augmented_reality_plugin.dart';
import 'package:flutter/material.dart';

class VirtualArScreen extends StatefulWidget {
  final String image;
  const VirtualArScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<VirtualArScreen> createState() => _VirtualArScreenState();
}

class _VirtualArScreenState extends State<VirtualArScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AugmentedRealityPlugin(widget.image),
    );
  }
}
