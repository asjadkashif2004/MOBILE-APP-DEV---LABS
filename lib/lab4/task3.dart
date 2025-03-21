import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scrollable ListView',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ListViewScreen(),
    );
  }
}

class ListViewScreen extends StatelessWidget {
  final List<Map<String, String>> items = [
    {"title": "Item 1", "subtitle": "This is the first item"},
    {"title": "Item 2", "subtitle": "This is the second item"},
    {"title": "Item 3", "subtitle": "This is the third item"},
    {"title": "Item 4", "subtitle": "This is the fourth item"},
    {"title": "Item 5", "subtitle": "This is the fifth item"},
    {"title": "Item 6", "subtitle": "This is the sixth item"},
    {"title": "Item 7", "subtitle": "This is the seventh item"},
    {"title": "Item 8", "subtitle": "This is the eighth item"},
    {"title": "Item 9", "subtitle": "This is the ninth item"},
    {"title": "Item 10", "subtitle": "This is the tenth item"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scrollable ListView'), centerTitle: true),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
                backgroundColor: Colors.blue.shade300,
              ),
              title: Text(
                items[index]['title']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(items[index]['subtitle']!),
              trailing: Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Clicked: ${items[index]['title']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
