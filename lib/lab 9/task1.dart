import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name']);
}

class Post {
  int id;
  String title;
  String body;

  Post({required this.id, required this.title, required this.body});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD JSONPlaceholder',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<User>> _users;
  List<Post> _posts = [];
  int _postIdCounter = 1000;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final List usersJson = json.decode(response.body);
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  void _createPost() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _posts.add(Post(
          id: _postIdCounter++,
          title: _titleController.text,
          body: _bodyController.text,
        ));
        _titleController.clear();
        _bodyController.clear();
      });
    }
  }

  void _editPost(Post post) {
    _titleController.text = post.title;
    _bodyController.text = post.body;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Post'),
        content: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) => value!.isEmpty ? 'Enter title' : null,
            ),
            TextFormField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: 'Body'),
              validator: (value) => value!.isEmpty ? 'Enter body' : null,
            ),
          ]),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  post.title = _titleController.text;
                  post.body = _bodyController.text;
                  _titleController.clear();
                  _bodyController.clear();
                });
                Navigator.of(context).pop();
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  void _deletePost(Post post) {
    setState(() {
      _posts.remove(post);
    });
  }

  @override
  void initState() {
    super.initState();
    _users = fetchUsers();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter CRUD with JSONPlaceholder')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<User>>(
              future: _users,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data!
                        .map((user) => ListTile(
                              title: Text(user.name),
                              subtitle: Text('ID: ${user.id}'),
                            ))
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Post Title'),
                    validator: (value) => value!.isEmpty ? 'Enter a title' : null,
                  ),
                  TextFormField(
                    controller: _bodyController,
                    decoration: InputDecoration(labelText: 'Post Body'),
                    validator: (value) => value!.isEmpty ? 'Enter a body' : null,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(onPressed: _createPost, child: Text('Create Post')),
                ]),
              ),
            ),
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editPost(post),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deletePost(post),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
