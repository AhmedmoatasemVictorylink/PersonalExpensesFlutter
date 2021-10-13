

import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import './tranaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return  transactions.isEmpty    // trenary expersion
      // in case of empty list
      ? LayoutBuilder(builder: (ctx, constarints) {
        return Column(children: [
        Text("There is no transactions"),
        SizedBox(height: 20,),
        Container(
          height: constarints.maxHeight * 0.6,
          child: Image.asset(
            "assets/images/cairofest.png",
            fit: BoxFit.cover,
            ))
      ],);
      }) 
      // in case of table view for expenses list
      // :  ListView.builder(
      //   itemBuilder: (ctx, index) {
      //     return TransactionItem(transaction: transactions[index], deleteTx: deleteTx);
      //   },
      //   itemCount: transactions.length,
      // );
      : ListView(
        children: transactions
          .map((tx) => TransactionItem(
            key: ValueKey(tx.id),
            transaction: tx,
            deleteTx: deleteTx,
            )).toList(),
      );
  }
}
