import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});
  @override
  ConsumerState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedCategory = "Food";
  bool _isIncome = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              validator: (val) => val == null || val.isEmpty ? "Enter amount" : null,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(labelText: "Category"),
              items: ["Food", "Transport", "Entertainment", "Other"]
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: "Note"),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Income?'),
              value: _isIncome,
              onChanged: (val) => setState(() => _isIncome = val),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final exp = Expense(
                    category: _selectedCategory,
                    amount: double.parse(_amountController.text),
                    date: DateTime.now(),
                    note: _noteController.text,
                    isIncome: _isIncome,
                  );
                  ref.read(expenseListProvider.notifier).addExpense(exp);
                  _amountController.clear();
                  _noteController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added!')));
                }
              },
              child: const Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
