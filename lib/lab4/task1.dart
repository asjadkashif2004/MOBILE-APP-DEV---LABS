import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple UI"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(child: HomeContent()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onFabPressed(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  static void _onFabPressed() {
    debugPrint("FAB Clicked!");
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.data_saver_off_rounded, size: 100, color: Colors.blue),
        const SizedBox(height: 20),
        const Text(
          "Welcome to Flutter",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _onButtonPressed(),
          child: const Text("Press Me"),
        ),
      ],
    );
  }

  static void _onButtonPressed() {
    debugPrint("Button Pressed!");
  }
}
