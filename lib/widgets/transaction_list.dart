import 'package:expense_app/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  // ignore: use_key_in_widget_constructors
  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constrains) {
            return Column(
              children: [
                const Text(
                  "No transactions Yet...",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  //decoration: BoxDecoration(color: Colors.amber),
                  height: constrains.maxHeight * 0.6,
                  child: const Image(
                    image: AssetImage('assets/images/flwaiting.png'),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return TransactionCard(
                  transaction: transactions[index], deleteTx: deleteTx);
            },
          );
  }
}
