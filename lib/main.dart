import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.orange,
          fontFamily: 'Roboto',
          textTheme: ThemeData.light().textTheme.copyWith(
              // apply global theme to title
              title: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              // apply local appbar theme to title
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'Anton', fontSize: 20)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final List<Transaction> _userTransaction = [];

List<Transaction> get _recentTransactions {
  return _userTransaction.where((tx) {
    return tx.date.isAfter(
      DateTime.now().subtract(
        Duration(days: 7),
      ),
    );
  }).toList();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere(((tx) => tx.id == id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('XPENSE'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList(_userTransaction, _deleteTransaction))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
