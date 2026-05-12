import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kharchabook/Data/database_helper.dart';
class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  List data = [];
  double total = 0;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    data = await DBHelper.getAll();

    total = 0;
    for (var e in data) {
      total += (e['amount'] ?? 0);
    }

    setState(() {});
  }

  void delete(int id) async {
    await DBHelper.delete(id);
    load();
  }

  String formatDate(String raw) {
    try {
      DateTime dt = DateTime.parse(raw);
      return "${dt.day}/${dt.month}/${dt.year}";
    } catch (e) {
      return raw;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [

          /// 🧠 TOP DASHBOARD CARD
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [Color(0xFF7C4DFF), Color(0xFF00D4FF)],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Expense",
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "This Month",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "₹${total.toStringAsFixed(0)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          /// 📜 LIST
          Expanded(
            child: data.isEmpty
                ? const Center(
              child: Text(
                "No Expenses Yet",
                style: TextStyle(color: Colors.white54),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: data.length,
              itemBuilder: (context, i) {
                final item = data[i];

                return Dismissible(
                  key: Key(item['id'].toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => delete(item['id']),

                  background: Container(
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),

                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),

                    child: Row(
                      children: [

                        /// 🟣 ICON
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.payments,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 12),

                        /// 📄 TITLE + DATE
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "📅 ${formatDate(item['date'])}",
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// 💰 AMOUNT
                        Text(
                          "₹${item['amount']}",
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}