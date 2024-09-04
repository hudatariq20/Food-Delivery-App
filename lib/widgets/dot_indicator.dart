import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator(
      {super.key,
      this.isActive = false,
      this.activeColor = const Color(0xFF22A45D),
      this.inactiveColor = const Color(0xFF868686)});

  final bool isActive;
  final Color activeColor, inactiveColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 5,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor.withOpacity(0.25),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
    );
  }
}
