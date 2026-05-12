import 'package:flutter/material.dart';
import 'package:kharchabook/Data/database_helper.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final title = TextEditingController();
  final amount = TextEditingController();

  void save() async {
    await DBHelper.insert({
      'title': title.text,
      'amount': double.parse(amount.text),
      'date': DateTime.now().toString(),
    });
    title.clear();
    amount.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Saved")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: title, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: amount, decoration: const InputDecoration(labelText: "Amount")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: save, child: const Text("Save",
            style: TextStyle(color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}