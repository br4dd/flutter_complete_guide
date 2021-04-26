import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;

  Transaction(
      {@required this.id,
      @required this.title,
      this.description,
      @required this.amount,
      @required this.date});
}
