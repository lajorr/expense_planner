// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class AddItemsPage extends StatefulWidget {
  const AddItemsPage({
    Key? key,
    required this.onTransaction,
  }) : super(key: key);

  final Function onTransaction;

  @override
  State<AddItemsPage> createState() => _AddItemsPageState();
}

class _AddItemsPageState extends State<AddItemsPage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void onSubmit() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.onTransaction(titleController.text,
        double.parse(amountController.text), _selectedDate);
  }

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,  
            bottom: MediaQuery.of(context).viewInsets.bottom + 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              textInputAction: TextInputAction.next,
              controller: titleController,
              style: TextStyle(fontSize: 24, letterSpacing: 3),
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  fontSize: 28,
                  letterSpacing: 0,
                ),
              ),
            ),
            TextField(
              style: TextStyle(fontSize: 24, letterSpacing: 3),
              keyboardType: TextInputType.number,
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(
                  fontSize: 28,
                  letterSpacing: 0,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   _selectedDate == null
                //       ? 'No Date Chosen'
                //       : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                //   style: TextStyle(
                //     fontSize: 20,
                //     letterSpacing: 0,
                //   ),
                // ),
                TextButton(
                  onPressed: datePicker,
                  child: Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: onSubmit,
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
