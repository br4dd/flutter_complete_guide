import 'dart:io';

import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
    String txTitle,
    String txDescription,
    double txAmount,
    DateTime chosenDate,
  ) {
    final newTx = Transaction(
      title: txTitle,
      description: txDescription,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

// TO DELETE THE TRANSACTION
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // to check if landscape mode
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('WiseSpend!'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    // reusable widget
    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height - //whole height of the view
              appBar.preferredSize.height - //appBar height
              MediaQuery.of(context)
                  .padding
                  .top) * //notification size or the top notch
          .7, // 70 percent height
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      //displaying recent transactions
      //todo : salary
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //showing switch if landscape
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLandscape)
                    //for making switch
                    Text('Show Chart'),
                  // Switch.adaptive() for adapting theme if ios is use
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            //DART DOES NOT ALLOW CURLY BRACES ON LIST IN CONDITION STATEMENTS
            if (!isLandscape)
              Container(
                height: (MediaQuery.of(context)
                            .size
                            .height - //whole height of the view
                        appBar.preferredSize.height - //appBar height
                        MediaQuery.of(context)
                            .padding
                            .top) * //notification size or the top notch
                    .3, // 30 percent height
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart //ternary function
                  //DYNAMIC SIZING
                  ? Container(
                      height: (MediaQuery.of(context)
                                  .size
                                  .height - //whole height of the view
                              appBar.preferredSize.height - //appBar height
                              MediaQuery.of(context)
                                  .padding
                                  .top) * //notification size or the top notch
                          .7, // 70 percent height
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //to check device plaform
      floatingActionButton: Platform.isIOS
          ? Container(
              child: Text('YOUR\'E USING AN IOS'),
            )
          : FloatingActionButton.extended(
              onPressed: () => _startAddNewTransaction(context),
              label: const Text(
                  'Add Transaction'), //adding const to save resources
              icon: Icon(Icons.add),
            ),
    );
  }
}
