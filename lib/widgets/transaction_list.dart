import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList');
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: constraints.maxHeight * .1,
                  ),
                  Container(
                    height: constraints.maxHeight * .4,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * .1,
                  ),
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return TransactionItem(
                    transaction: transactions[index], deleteTx: deleteTx);
              },
              itemCount: transactions.length,
              // children: transactions.map((tx) {

              // }).toList(),
            ),
    );
  }
}
