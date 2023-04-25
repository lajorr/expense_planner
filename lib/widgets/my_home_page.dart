// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../add_items_page.dart';
import '../models/data.dart';
import '../models/transaction.dart';
import 'expense_chart.dart';
import 'expense_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var showChart = true;
  void onTransaction(String title, double amount, DateTime datePicked) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: datePicked,
    );
    setState(() {
      txData.add(newTx);
    });
    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      txData.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void onPressedAddItem(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddItemsPage(
            onTransaction: onTransaction,
          );
        });
  }

  List<Transaction> get _recentTransaction {
    return txData.where(
      (element) {
        return element.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(child: Text("Show Chart")),
          Switch(
              value: showChart,
              onChanged: (val) {
                setState(() {
                  showChart = val;
                });
              })
        ],
      ),
      showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.8,
              child: ExpenseChart(
                recentTransaction: _recentTransaction,
              ),
            )
          : txList,
    ];
  }

  List<Widget> _buildPortraitCotent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txList) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: ExpenseChart(
          recentTransaction: _recentTransaction,
        ),
      ),
      txList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Expense Tracker'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => onPressedAddItem(context),
          //  () => addItem(context),
        ),
      ],
    );
    final txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: ExpenseList(
        onDelete: _deleteTransaction,
      ),
    );

    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.grey[200],
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.purple[800],
        onPressed: () => onPressedAddItem(context),
        // () => addItem(context),
        child: Icon(
          Icons.add,
          size: 36,
        ),
      ),
      body: SingleChildScrollView(child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              if (isLandscape)
                ..._buildLandscapeContent(mediaQuery, appBar, txList),
              if (!isLandscape)
                ..._buildPortraitCotent(mediaQuery, appBar, txList),
              if (!isLandscape) txList
            ],
          );
        },
      )),
    );
  }
}
