import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Complex UI',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ComplexUIPage(),
    );
  }
}

class ComplexUIPage extends StatefulWidget {
  @override
  _ComplexUIPageState createState() => _ComplexUIPageState();
}

class _ComplexUIPageState extends State<ComplexUIPage> {
  final TextEditingController _nameController = TextEditingController();
  String _displayText = "Welcome!";

  void _updateText() {
    setState(() {
      _displayText = "Hello, ${_nameController.text}!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complex UI Example'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    _displayText,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Enter your name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(onPressed: _updateText, child: Text('Submit')),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconContainer(Icons.home, "Home"),
                _buildIconContainer(Icons.settings, "Settings"),
                _buildIconContainer(Icons.person, "Profile"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 30, color: Colors.white),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
