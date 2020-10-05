import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
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
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text(
                                '\€${transactions[index].amount.toStringAsFixed(2)}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMEd().format(transactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 360
                        ? FlatButton.icon(
                            onPressed: () => deleteTx(transactions[index].id),
                            textColor: Theme.of(context).errorColor,
                            icon: Icon(Icons.delete),
                            label: Text('Delete'))
                        : IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteTx(transactions[index].id),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
              // children: transactions.map((tx) {

              // }).toList(),
            ),
    );
  }
}
