import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'expense_list.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.tx,
    required this.widget,
  }) : super(key: key);

  final Transaction tx;
  final ExpenseList widget;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? _bgColor;

  @override
  void initState() {
    const colors = [
      Colors.red,
      Colors.blue,
      Colors.purple,
      Colors.pink,
    ];

    _bgColor = colors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _bgColor!,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text('\$${widget.tx.amount}'),
            ),
          ),
          title: Text(
            widget.tx.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.tx.date),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          trailing: MediaQuery.of(context).size.width > 400
              ? TextButton.icon(
                  onPressed: () => widget.widget.onDelete(widget.tx.id),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "Delete",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : IconButton(
                  onPressed: () => widget.widget.onDelete(widget.tx.id),
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
        ),
      ),
    );
  }
}
