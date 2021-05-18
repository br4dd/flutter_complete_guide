import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          //adding layout builder to access constraints for height
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      child: FittedBox(
                        child: Text('\₱${transactions[index].amount}'),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transactions[index].description,
                        ),
                        Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                        ),
                      ],
                    ),
                    // to add adjustable something
                    // MediaQuery.of(context).size.width > 360
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        showModalBottomSheet(
                          context: ctx,
                          builder: (_) {
                            //DELETING TRANSACTION
                            return SingleChildScrollView(
                              child: Card(
                                child: (Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Are you sure you want to delete this ${transactions[index].title}?',
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              deleteTx(transactions[index].id);
                                            },
                                            //deleteTx(transactions[index].id)
                                            child: Text('Yes'),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text('No'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            );
                          },
                        );
                      },

                      // onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
