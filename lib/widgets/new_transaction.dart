
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {

    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime(2021,),
       lastDate: DateTime.now(),
       ).then((pickedDate) {
         if (pickedDate == null) {
           return;
         }
         setState(() {
            _selectedDate = pickedDate;
         });
       });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(   // title text filed
                decoration: const InputDecoration(labelText: "Title"),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(    // amount text filed
                decoration: const InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(children: [
                  Expanded(
                    child: Text(   // picked date text
                      _selectedDate == null 
                        ?  "No date chosen" 
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'
                        ),
                  ),
                  Platform.isIOS ? CupertinoButton(
                    onPressed: _presentDatePicker,
                  child: const Text(
                    "Chose date",
                    style: TextStyle(fontWeight: FontWeight.bold,),
                    ),
                  ) : TextButton(   // choose date button
                  onPressed: _presentDatePicker,
                  child: const Text(
                    "Chose date",
                    style: TextStyle(fontWeight: FontWeight.bold,),
                    ),
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                )
                ],),
              ),
              ElevatedButton(   // add transaction button
                onPressed: _submitData,
                child: const Text("Add transaction"),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,//change background color of button
                    onPrimary: Theme.of(context).textTheme.button!.color,//change text color of button
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 15.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
