import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
