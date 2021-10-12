

import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty ? Column(children: [
        Text("There is no transactions"),
        SizedBox(height: 20,),
        Container(
          height: 200,
          child: Image.asset(
            "assets/images/cairofest.png",
            fit: BoxFit.cover,
            ))
      ],) :  ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text("\$${transactions[index].amount}"
                    )
                    ),
                ),
              ),
              title: Text(transactions[index].title),
              subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteTx(transactions[index].id),
                color: Theme.of(context).errorColor,
                ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}