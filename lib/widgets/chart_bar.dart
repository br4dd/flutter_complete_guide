import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text('\₱${spendingAmount.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 80,
          width: 30,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}

// Container(
//   height: 65,
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(10),
//     color: Colors.deepPurple.shade100,
//   ),
//   child: Stack(
//     children: <Widget>[
//       Container(
//         width: 8,

//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(15),
//               bottomLeft: Radius.circular(15)),
//           color: Colors.deepPurple,
//         ),
//       )
//     ],
//   ),
// )
