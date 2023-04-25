// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/data.dart';
import 'transaction_item.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({
    Key? key,
    required this.onDelete,
  }) : super(key: key);
  final Function onDelete;

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return (txData.isEmpty)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.2,
                      child: FittedBox(
                        child: Text(
                          'No Transaction Added yet!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.7,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        : Expanded(
            child: ListView(
              key: UniqueKey(),
              children: txData
                  .map((tx) => TransactionItem(
                        key: ValueKey(tx.id),
                        tx: tx,
                        widget: widget,
                      ))
                  .toList(),
            ),
          );
  }
}
