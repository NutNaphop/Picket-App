import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  GradientBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF6A82FB), Color(0xFFFC5C7D)],
        ),
      ),
      child: child,
    );
  }
}
