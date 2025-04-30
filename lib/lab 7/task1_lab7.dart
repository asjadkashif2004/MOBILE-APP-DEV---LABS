import 'package:flutter/material.dart';

void main() => runApp(TimerApp());

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CountdownScreen(),
    );
  }
}

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  int _seconds = 10;
  bool _isRunning = false;

  void _startTimer() async {
    setState(() => _isRunning = true);
    for (int i = _seconds; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      setState(() => _seconds = i);
    }
    setState(() => _isRunning = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Countdown Timer")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_seconds', style: TextStyle(fontSize: 50)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: !_isRunning ? _startTimer : null,
              child: Text("Start Timer"),
            ),
          ],
        ),
      ),
    );
  }
}
