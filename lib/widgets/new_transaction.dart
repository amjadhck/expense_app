import 'dart:io';
// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:expense_app/widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final entiredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (entiredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(entiredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
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
      child: Card(
        color: Colors.grey,
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add Transaction',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (value) {
                  _submitData();
                },
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  _submitData();
                },
              ),
              // SizedBox(
              //   height: 80,
              // ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen :'
                          : "Picked Date :  ${DateFormat.yMd().format(_selectedDate!)}"),
                    ),
                    AdaptiveButton(
                        title: 'Choose Date', handler: _presentDatePicker),
                  ],
                ),
              ),
              AdaptiveButton(title: 'Add transaction', handler: _submitData),
              //textColor: Colors.purple,
            ],
          ),
        ),
      ),
    );
  }
}
