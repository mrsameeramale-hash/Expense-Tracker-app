import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kharchabook/screens/add_screen.dart';
import 'package:kharchabook/screens/analytics_screen.dart';
import 'package:kharchabook/expense/expense_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  ///  ONLY 2 SCREENS
  final screens = const [
    ExpenseList(),
    AnalyticsScreen(),
  ];

  void openAdd() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddScreen()),
    );
    setState(() {}); // refresh after add
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      /// 🌌 BACKGROUND
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF2C5364),
                  Color(0xFF1c1c1c),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(child: screens[index]),
        ],
      ),

      /// ➕ CENTER FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: openAdd,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xFF7C4DFF),
                Color(0xFF00D4FF),
              ],
            ),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /// 🧊 BOTTOM NAV
      bottomNavigationBar: glassNavBar(),
    );
  }

  /// 🧊 GLASS NAV BAR (FIXED ALIGNMENT)
  Widget glassNavBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),

            /// 🔥 LEFT - RIGHT PERFECT ALIGNMENT
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: navItem(Icons.home, "Home", 0),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: navItem(Icons.bar_chart, "Stats", 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔘 NAV ITEM
  Widget navItem(IconData icon, String label, int i) {
    bool selected = index == i;

    return GestureDetector(
      onTap: () => setState(() => index = i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? Colors.white.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : Colors.grey,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: selected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}