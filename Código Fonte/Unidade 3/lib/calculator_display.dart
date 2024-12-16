import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final String value;
  const Display({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerRight,  // Alinha o texto à direita
        child: FittedBox(
          fit: BoxFit.contain, 
          child: Text(
            value,
            style: const TextStyle(fontSize: 100.0, color: Colors.white),  // Tamanho inicial
          ),
        ),
      ),
    );
  }
}
