import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
                child: Text('\€${transaction.amount.toStringAsFixed(2)}')),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(DateFormat.yMMMEd().format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                onPressed: () => deleteTx(transaction.id),
                textColor: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete),
                label: const Text(
                    'Delete')) // gebruik const bij immutable objecten waarvan je weet dat het niet verandert tijdens het renderen. Verbetert performance!
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => deleteTx(transaction.id),
              ),
      ),
    );
  }
}
