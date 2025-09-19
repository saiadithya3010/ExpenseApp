import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/expense_provider.dart';

class ReportScreen extends ConsumerWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expenseListProvider);
    final Map<String, double> dataMap = {};
    for (var exp in expenses) {
      if (!exp.isIncome) {
        dataMap[exp.category] = (dataMap[exp.category] ?? 0) + exp.amount;
      }
    }
    if (dataMap.isEmpty) dataMap['None'] = 1;
    final List<PieChartSectionData> sections = dataMap.entries
      .map((e) => PieChartSectionData(
        value: e.value,
        title: e.key,
        color: Colors.primaries[dataMap.keys.toList().indexOf(e.key) % Colors.primaries.length],
      )).toList();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PieChart(
        PieChartData(
          sections: sections,
          centerSpaceRadius: 40,
          sectionsSpace: 4,
        ),
      ),
    );
  }
}
