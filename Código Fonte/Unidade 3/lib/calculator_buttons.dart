import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String symbol;
  final Function() func;

  const CalculatorButton(this.symbol, this.func, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ElevatedButton(
        onPressed: func,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          symbol,
          style: TextStyle(
            color: Colors.amber[50],
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
