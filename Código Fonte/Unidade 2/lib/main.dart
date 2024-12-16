import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Layout",
      home: Layout(),
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
        title: const Text("Nome do Programa"),
        centerTitle: true,
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            double proportion = 3 / 4;
            double maxHeight = 480;
            
            double height = (screenHeight > maxHeight ? screenHeight * 0.8 : screenHeight);
            double width = height * proportion;

            if (screenWidth < 430)
            {
              width = screenWidth;
              height = width / proportion;
            }

            return Container(
              width: width,
              height: height,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Programa',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}