import 'dart:async';
import 'package:expense_manager/models/transaction_type.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AmountInput extends StatefulWidget {
  final TransactionType selectedType;
  final TextEditingController controller;
  const AmountInput({super.key,required this.selectedType,required this.controller});

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  Timer? timer;
  Timer? delayTimer;

  @override
  void dispose() {
    timer?.cancel();
    delayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: theme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          children: [
            Text('Transaction Amount', style: textTheme.labelMedium),
            Row(
              children: [
                Text(
                  '\$',
                  style: textTheme.titleLarge!.copyWith(
                    color:widget.selectedType==TransactionType.expense?theme.error:AppColors.success,
                    fontSize: 30,
                  ),
                ),
                _buildAmountField(textTheme),
                Column(
                  children: [
                    _buildChangeButton(
                      icon: Icons.arrow_drop_up,
                      onTapDown: increaseAmount,
                    ),
                    const SizedBox(height: 5),
                    _buildChangeButton(
                      icon: Icons.arrow_drop_down,
                      onTapDown: decreaseAmount,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAmountButton(textTheme, 10),
                _buildAmountButton(textTheme, 50),
                _buildAmountButton(textTheme, 100),
                _buildAmountButton(textTheme, 500),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountButton(TextTheme textTheme, int amount) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        addAmount(amount);
      },
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.surfaceLight,
        ),
        child: Text(
          '+\$$amount',
          style: textTheme.labelMedium!.copyWith(
            fontSize: 15,
            fontFamily: GoogleFonts.manrope().fontFamily,
            color: AppColors.primaryText,
          ),
        ),
      ),
    );
  }

  Widget _buildChangeButton({
    required IconData icon,
    required VoidCallback onTapDown,
  }) {
    return InkWell(
      onTapDown: (_) {
        onTapDown();
        startChanging(onTapDown);
      },
      onTapUp: (_) {
        stopChanging();
      },
      onTapCancel: stopChanging,
      child: Icon(icon),
    );
  }

  Widget _buildAmountField(TextTheme textTheme) {
    return Expanded(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: textTheme.titleLarge!.copyWith(color: AppColors.mutedText),
        keyboardType: TextInputType.number,
        validator: (value) {
          
          final text = value?.trim() ?? '';

          if (text.isEmpty) {
            return 'Please enter an amount';
          }

          final pattern = RegExp(r'^(?=.*[1-9])((0\.\d*)|([1-9]\d*(\.\d*)?)|\.\d+)$');

          if (!pattern.hasMatch(text)) {
            return 'Invalid amount';
          }

          return null;
        },
        inputFormatters: [FilteringTextInputFormatter.deny(',')],
        decoration: InputDecoration(
          hintText: '0',
          hintStyle: textTheme.titleLarge!.copyWith(
            color: AppColors.hintTextColor,
          ),
        ),
        textAlign: TextAlign.center,
        controller: widget.controller,
      ),
    );
  }

  void increaseAmount() {
    num? value = num.tryParse(widget.controller.text);
    value ??= 0;
    value += 0.01;
    widget.controller.text = value.toStringAsFixed(2);
  }

  void decreaseAmount() {
    num? value = num.tryParse(widget.controller.text);
    if (value == null || value == 0 || value < 0.01) {
      return;
    }
    value -= 0.01;
    widget.controller.text = value.toStringAsFixed(2);
  }

  void startChanging(VoidCallback changeAmount) {
    timer?.cancel();
    delayTimer?.cancel();

    delayTimer = Timer(const Duration(milliseconds: 150), () {
      timer = Timer.periodic(const Duration(milliseconds: 70), (_) {
        changeAmount();
      });
    });
  }

  void stopChanging() {
    delayTimer?.cancel();
    timer?.cancel();

    delayTimer = null;
    timer = null;
  }

  void addAmount(int amount) {
    num? value = num.tryParse(widget.controller.text);
    value ??= 0;
    value += amount;
    widget.controller.text = value.toStringAsFixed(2);
  }
}
