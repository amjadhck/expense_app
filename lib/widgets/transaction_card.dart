import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade700,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                "₹${transaction.amount.toStringAsFixed(0)}",
              ),
            ),
          ),
        ),
        title: Text(transaction.title),
        subtitle: Text(
          DateFormat.yMMMMEEEEd().format(transaction.date),
        ),
        trailing: IconButton(
          onPressed: () {
            deleteTx(transaction.id);
          },
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
      ),
    );
  }
}