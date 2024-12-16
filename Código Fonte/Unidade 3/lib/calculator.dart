import 'package:flutter/material.dart';
import 'package:app_layout/calculator_keypad.dart';
import 'calculator_display.dart';
import 'package:app_layout/calculator_logic.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  late Logic logic;
  String display = "0";

  @override
  void initState()
  {
    super.initState();
    logic = Logic(updateDisplay);
  }

  void updateDisplay()
  {
    setState(() {
      display = logic.currentExpression;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(flex: 1, child: Display(value: display)),
            Divider(
              color: Colors.amber[50],
              indent: 15,
              endIndent: 15,
            ),
            Expanded(
                flex: 8,
                child: Keypad(
                  logic.numberFunction, logic.operationFunction
                )),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: ElevatedButton(
                    onPressed: logic.clear,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.grey[700]),
                    child: Text(
                      "Apagar",
                      style: TextStyle(color: Colors.amber[50]),
                    )),
              ),
            ),
          ],
        ));
  }
}
