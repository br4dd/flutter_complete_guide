import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 35,
          child: Padding(
            padding: const EdgeInsets.all(6), //adding const to save resources
            child: FittedBox(
              child: Text('\₱${transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.description,
            ),
            Text(
              DateFormat.yMMMd().format(transaction.date),
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
              context: context,
              builder: (_) {
                //DELETING TRANSACTION
                return SingleChildScrollView(
                  child: Card(
                    child: (Container(
                      child: Column(
                        children: [
                          Text(
                            'Are you sure you want to delete this ${transaction.title}?',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  deleteTx(transaction.id);
                                },
                                //deleteTx(transactions[index].id)
                                child: Text('Yes'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
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
  }
}
