import 'package:flutter/material.dart';
import 'package:app_layout/calculator.dart';


void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Layout(),
      title: "Calculadora",
    );
  }
}

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  LayoutState createState() => LayoutState();
}

class LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora"),
        centerTitle: true,
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            double proportion = 3 / 4;
            double maxHeight = 480;

            double height =
                (screenHeight > maxHeight ? screenHeight * 0.8 : screenHeight);
            double width = height * proportion;

            if (screenWidth < 430) {
              width = screenWidth;
              height = width / proportion;
            }

            return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Calculator(),
                );
                
          },
        ),
      ),
    );
  }
}
