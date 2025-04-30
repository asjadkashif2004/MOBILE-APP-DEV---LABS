import 'package:flutter/material.dart';

void main() => runApp(DatabaseSimApp());

class DatabaseSimApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SimulatedDatabaseScreen(),
    );
  }
}

class SimulatedDatabaseScreen extends StatefulWidget {
  @override
  _SimulatedDatabaseScreenState createState() => _SimulatedDatabaseScreenState();
}

class _SimulatedDatabaseScreenState extends State<SimulatedDatabaseScreen> {
  List<String>? _data;
  bool _loading = true;

  Future<void> _simulateDatabaseFetch() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _data = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _simulateDatabaseFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simulated DB Fetch")),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _data!.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(_data![index]));
        },
      ),
    );
  }
}
