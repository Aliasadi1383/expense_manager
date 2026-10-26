import 'package:flutter/material.dart';

class AnimatedPressable extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const AnimatedPressable({super.key,required this.child,required this.onTap});

  @override
  State<AnimatedPressable> createState() {
    return _AnimatedPressableState ();
  }
}

class _AnimatedPressableState extends State<AnimatedPressable> {
   bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isPressed?0.9:1.0, 
      duration:const Duration(milliseconds: 100),
    child: GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed=true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed=false;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed=false;
        });
      },
      onTap: widget.onTap,
      child: widget.child,
    ),
    );
  }
}
