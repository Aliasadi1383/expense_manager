import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InteractiveText extends StatefulWidget {
  final String text;
  final VoidCallback changePage;
  const InteractiveText({super.key, required this.text,required this.changePage});

  @override
  State<InteractiveText> createState() => _InteractiveText();
}

class _InteractiveText extends State<InteractiveText> {
  bool isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
      },

      onTapCancel: () {
        setState(() {
          isPressed=false;
        });
      },
      onTap: widget.changePage,
      child: Text(
        widget.text,
        style: textTheme.bodySmall!.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.hankenGrotesk().fontFamily,
          color: theme.primary,
          decoration: isPressed?TextDecoration.underline:TextDecoration.none,
          decorationColor: theme.primary,
          decorationThickness: 2
        ),
      ),
    );
  }
}
