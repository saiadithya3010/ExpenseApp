import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/expense.dart';

final expenseListProvider = StateNotifierProvider<ExpenseListNotifier, List<Expense>>((ref) {
  return ExpenseListNotifier();
});

class ExpenseListNotifier extends StateNotifier<List<Expense>> {
  late Box<Expense> box;

  ExpenseListNotifier() : super([]) {
    _init();
  }

  Future<void> _init() async {
    box = Hive.box<Expense>('expenses'); // safely access the box here
    state = box.values.toList();
  }

  void addExpense(Expense exp) {
    box.add(exp);
    state = box.values.toList();
  }

  void editExpense(int idx, Expense exp) {
    box.putAt(idx, exp);
    state = box.values.toList();
  }

  void removeExpense(int idx) {
    box.deleteAt(idx);
    state = box.values.toList();
  }
}

