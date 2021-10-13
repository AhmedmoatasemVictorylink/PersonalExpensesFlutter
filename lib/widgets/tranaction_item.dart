import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';


class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color? _bgColor;

  @override
  void initState() {
    const availableColrs = [Colors.red, Colors.black, Colors.blue, Colors.purple];

    _bgColor = availableColrs[Random().nextInt(4)];

    super.initState();
  }
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
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding:  EdgeInsets.all(6),
            child: FittedBox(
              child: Text("\$${widget.transaction.amount}"
              )
              ),
          ),
        ),
        title: Text(widget.transaction.title),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460 
        ? TextButton.icon(
          onPressed: () => widget.deleteTx(widget.transaction.id),
          icon: Icon(Icons.delete),
          label: Text("delete"),
          style: TextButton.styleFrom(
              primary: Theme.of(context).errorColor,
            ),
          )
        : IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => widget.deleteTx(widget.transaction.id),
          color: Theme.of(context).errorColor,
          ),
      ),
    );
  }
}