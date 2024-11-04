import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Expanded(
          child: Center(
        child: CircularProgressIndicator(),
      ) // Show loading indicator while
          ),
    ]);
  }
}
