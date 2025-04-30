import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(ApiApp());

class ApiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ApiScreen(),
    );
  }
}

class ApiScreen extends StatefulWidget {
  @override
  _ApiScreenState createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  Map<String, dynamic>? _post;
  bool _loading = false;

  Future<void> fetchPost() async {
    setState(() => _loading = true);
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

    if (response.statusCode == 200) {
      setState(() {
        _post = json.decode(response.body);
        _loading = false;
      });
    } else {
      setState(() {
        _post = {"error": "Failed to load post"};
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fetch API Example")),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : _post != null
            ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Title: ${_post!["title"]}\n\nBody: ${_post!["body"]}',
            style: TextStyle(fontSize: 18),
          ),
        )
            : Text("No data"),
      ),
    );
  }
}
