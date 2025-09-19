import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/expense_provider.dart';

// ignore: use_key_in_widget_constructors
class ExpenseList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expenseListProvider);
    if (expenses.isEmpty) {
      return const Center(child: Text('No transactions yet.'));
    }
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final exp = expenses[index];
        return Card(
          child: ListTile(
            title: Text(exp.category),
            subtitle: Text('${exp.note} - ${exp.date.toString()}'),
            trailing: Text(exp.isIncome ? '+ ₹${exp.amount}' : '- ₹${exp.amount}', style: TextStyle(color: exp.isIncome ? Colors.green : Colors.red)),
            onTap: () {
              // Optionally implement editing logic
            },
            onLongPress: () {
              ref.read(expenseListProvider.notifier).removeExpense(index);
            },
          ),
        );
      },
    );
  }
}
