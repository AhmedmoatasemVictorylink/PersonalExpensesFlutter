import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';


class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin:  EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5
      ),
      // table view of expenses 
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding:  EdgeInsets.all(6),
            child: FittedBox(
              child: Text("\$${transaction.amount}"
              )
              ),
          ),
        ),
        title: Text(transaction.title),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460 
        ? TextButton.icon(
          onPressed: () => deleteTx(transaction.id),
          icon: Icon(Icons.delete),
          label: Text("delete"),
          style: TextButton.styleFrom(
              primary: Theme.of(context).errorColor,
            ),
          )
        : IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => deleteTx(transaction.id),
          color: Theme.of(context).errorColor,
          ),
      ),
    );
  }
}