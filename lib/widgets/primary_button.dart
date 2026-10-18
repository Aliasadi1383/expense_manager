import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
        minimumSize: Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 14,
              color: theme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
