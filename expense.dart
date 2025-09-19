import 'package:hive/hive.dart';



@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  String category;
  @HiveField(1)
  double amount;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  String note;
  @HiveField(4)
  bool isIncome;

  Expense({
    required this.category,
    required this.amount,
    required this.date,
    required this.note,
    required this.isIncome,
  });
}
