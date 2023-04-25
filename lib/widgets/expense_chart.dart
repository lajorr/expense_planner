// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expense_planner_2/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

import 'package:expense_planner_2/models/transaction.dart';
import 'package:intl/intl.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({
    Key? key,
    required this.recentTransaction,
  }) : super(key: key);

  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekday = DateTime.now().subtract(
          Duration(days: index),
        );
        var totalSum = 0.0;

        for (var i = 0; i < recentTransaction.length; i++) {
          if (recentTransaction[i].date.day == weekday.day &&
              recentTransaction[i].date.year == weekday.year &&
              recentTransaction[i].date.month == weekday.month) {
            totalSum += recentTransaction[i].amount;
          }
        }

        return {
          'day': DateFormat.E().format(weekday).substring(0, 2),
          'amount': totalSum,
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Theme.of(context).backgroundColor,
        elevation: 6,
        margin: EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((e) {
              return Expanded(
                // fit: FlexFit.tight,
                child: ChartBar(
                    label: (e['day'] as String),
                    spendingAmount: (e['amount'] as double),
                    spendingPctOfTotal: totalSpending == 0.0
                        ? 0.0
                        : (e['amount'] as double) / totalSpending),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
