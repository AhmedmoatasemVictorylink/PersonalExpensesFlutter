import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/Transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
          button: const TextStyle(color: Colors.white),
        )
       // colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.amber),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String? titleInput;
  // String? amountInput;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
    //  Transaction(
    //   id: "t1",
    //   title: "New shoes",
    //   amount: 97.77,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Weekly groceries",
    //   amount: 55.78,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where( (tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
          ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
      title: txTitle,
       amount: txAmount,
       date: choosenDate,
       id: DateTime.now().toString(),
       );

       setState(() {
         _userTransactions.add(newTx);
       });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        child: NewTransaction(_addNewTransaction),
        onTap: () => {},
        behavior: HitTestBehavior.opaque,
      );
    });
  }

  void _deletetransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  // app bar
        title: Text("Personal Expenses"),  // app bar title
        actions: [
          IconButton(     // app bar button
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(   
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // chart here
            Chart(_recentTransactions),     // chart 

            // text input card and transaction list here
            TransactionList(_userTransactions, _deletetransaction),    // tranactions list
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
