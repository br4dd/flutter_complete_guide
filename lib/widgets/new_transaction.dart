import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    //CHECK IF AMOUNT IS EMPTY
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredDescription = _descriptionController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty ||
        // enteredDescription.isEmpty ||
        enteredAmount <= 0 ||
        _selectedDate == null) return;

    widget.addTx(
      // titleController.text,
      // double.parse(amountController.text),
      enteredTitle,
      enteredDescription,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  // SHOWING DATE //
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      // DATE RANGER //
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (value) => titleInput = value,
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                // onChanged: (value) => titleInput = value,
                controller: _descriptionController,
                onSubmitted: (_) => _submitData(),
              ),
              //AMOUNT WITH DOUBLE TYPE INPUT ONLY
              TextField(
                //FOR CURRENCY INPUT//
                // keyboardType: TextInputType.numberWithOptions(decimal: true),
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                // ],
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),

                // onChanged: (value) => amountInput = value,
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              // FOR THE DATE FIELD //
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(),
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Add Transaction'),
                // style: TextButton.styleFrom(
                //     // primary: Colors.green,
                //     ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
