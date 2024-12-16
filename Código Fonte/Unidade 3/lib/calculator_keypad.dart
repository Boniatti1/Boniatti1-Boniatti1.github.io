import 'package:app_layout/calculator_buttons.dart';
import 'package:flutter/material.dart';

class Keypad extends StatelessWidget {
  final void Function(String) numberFunction;
  final void Function(String) operationFunction;

  const Keypad(this.numberFunction, this.operationFunction, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      padding: const EdgeInsets.all(20),
      children: [
        CalculatorButton("1", () => numberFunction("1")),
        CalculatorButton("2", () => numberFunction("2")),
        CalculatorButton("3", () => numberFunction("3")),
        CalculatorButton("/", () => operationFunction("/")),
        CalculatorButton("4", () => numberFunction("4")),
        CalculatorButton("5", () => numberFunction("5")),
        CalculatorButton("6", () => numberFunction("6")),
        CalculatorButton("*", () => operationFunction("*")),
        CalculatorButton("7", () => numberFunction("7")),
        CalculatorButton("8", () => numberFunction("8")),
        CalculatorButton("9", () => numberFunction("9")),
        CalculatorButton("-", () => operationFunction("-")),
        CalculatorButton(".", () => numberFunction(".")),
        CalculatorButton("0", () => numberFunction("0")),
        CalculatorButton("=", () => operationFunction("=")),
        CalculatorButton("+", () => operationFunction("+")),
      ],
    );
  }
}
