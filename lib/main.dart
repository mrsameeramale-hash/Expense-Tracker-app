import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',

      /// 🌙 PREMIUM DARK FINTECH THEME (NOT PURE BLACK / NOT WHITE)
      theme: ThemeData(
        useMaterial3: true,

        brightness: Brightness.dark,

        /// 🎨 CORE COLOR SYSTEM (IMPORTANT)
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7C4DFF),   // premium purple
          secondary: Color(0xFF00D4FF), // cyan accent
          surface: Color(0xFF121826),   // card background
          background: Color(0xFF0B0F1A), // app background
        ),

        /// 🌌 MAIN BACKGROUND (SOFT DARK, NOT PURE BLACK)
        scaffoldBackgroundColor: const Color(0xFF0B0F1A),

        /// 🔤 TEXT STYLE (clean contrast)
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),

        /// 🧊 APP BAR
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),

        /// ➕ FLOATING BUTTON
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF7C4DFF),
          foregroundColor: Colors.white,
          elevation: 6,
        ),

        /// 🔘 BOTTOM NAV (MATCH DARK STYLE)
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF121826),
          selectedItemColor: Color(0xFF7C4DFF),
          unselectedItemColor: Colors.white54,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 10,
        ),
      ),

      home: const HomeScreen(),
    );
  }
}
