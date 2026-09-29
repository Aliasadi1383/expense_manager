import 'package:expense_manager/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ).copyWith(primary: Color(0xFF4338CA)),
        textTheme: TextTheme(
          labelMedium: GoogleFonts.hankenGrotesk(
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),
        )
      ),
      
      home: MainScreen(),
    );
  }
}
