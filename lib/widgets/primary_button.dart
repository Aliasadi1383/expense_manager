import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? icon;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:backgroundColor?? theme.primary,
        foregroundColor:foregroundColor?? theme.onPrimary,
        minimumSize: Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(icon!=null)...[
          Icon(icon),
          const SizedBox(width: 5),
          ],
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 14,
              color:textColor?? theme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
