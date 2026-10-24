import 'package:expense_manager/screen/main_screen.dart';
import 'package:expense_manager/state/page_state.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:expense_manager/state/transaction_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionState()),
        ChangeNotifierProvider(create: (_) => PageState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFFBF7F8),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ).copyWith(primary: Color(0xFF4338CA)),
          textTheme: TextTheme(
            labelMedium: GoogleFonts.hankenGrotesk(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.mutedText,
            ),
            titleMedium: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
            titleLarge: GoogleFonts.manrope(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
            labelSmall: GoogleFonts.hankenGrotesk(
              fontSize: 11,
              fontWeight: FontWeight.normal,
              color: AppColors.mutedText,
            ),
            bodySmall: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
        ),
        home: MainScreen(),
      ),
    );
  }
}
