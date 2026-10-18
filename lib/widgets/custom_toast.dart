import 'package:flutter/material.dart';

class CustomToast {
 static OverlayEntry? _currentEntry;
  static void show(BuildContext context, String message, Icon icon) {
    final overlay = Overlay.of(context);

     if (_currentEntry != null) {
      _currentEntry!.remove();
      _currentEntry!.dispose();
      _currentEntry = null;
    }

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => _ToastAnimation(
        icon: icon,
        message: message,
        onFinished: () {
          if (_currentEntry == entry) {
            entry.remove();
            entry.dispose();
            _currentEntry = null;
          }
        },
      ),
    );
    _currentEntry=entry;
    overlay.insert(entry);
  }
}

class _ToastAnimation extends StatefulWidget {
  final Icon icon;
  final String message;
  final VoidCallback onFinished;

  const _ToastAnimation({
    required this.icon,
    required this.message,
    required this.onFinished,
  });

  @override
  State<_ToastAnimation> createState() {
    return _ToastAnimationState();
  }
}

class _ToastAnimationState extends State<_ToastAnimation> {
  bool isVisible = false;
  bool isFadingOut = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  Future<void> _startAnimation() async {
  await Future.delayed(const Duration(milliseconds: 10));

  if (!mounted) return;

  setState(() {
    isVisible = true;
  });

  await Future.delayed(const Duration(milliseconds: 100));
  await Future.delayed(const Duration(milliseconds: 1500));

  if (!mounted) return;

  setState(() {
    isFadingOut = true;
  });

  await Future.delayed(const Duration(milliseconds: 250));

  if (!mounted) return;

  widget.onFinished();
}

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.paddingOf(context).top + 15,
      left: 0,
      right: 0,
      child: AnimatedSlide(
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 100),
        offset: isVisible ? Offset.zero : Offset(0, 1),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 250),
          opacity: isFadingOut ? 0.0 : 1.0,

          child: Center(
            child: Material(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.icon,
                    const SizedBox(width: 5),
                    Text(
                      widget.message,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
