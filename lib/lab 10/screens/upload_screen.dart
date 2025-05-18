import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/post.dart';

class UploadScreen extends StatefulWidget {
  static const route = '/upload';
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _title = TextEditingController();
  final _desc = TextEditingController();
  XFile? _picked;

  Future<void> _pick() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) setState(() => _picked = img);
  }

  Future<void> _upload() async {
    if (_picked == null || _title.text.isEmpty) return;
    final file = File(_picked!.path);
    final name = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref('posts/$name.jpg');
    await ref.putFile(file);
    final url = await ref.getDownloadURL();

    final post = Post(
      id: '',
      title: _title.text,
      description: _desc.text,
      imageUrl: url,
    );
    await FirebaseFirestore.instance.collection('posts').add(post.toJson());
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('New Post')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          TextField(controller: _title, decoration: const InputDecoration(labelText: 'Title')),
          const SizedBox(height: 12),
          TextField(
            controller: _desc,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          _picked == null
              ? const Placeholder(fallbackHeight: 150)
              : Image.file(File(_picked!.path), height: 150, fit: BoxFit.cover),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _pick,
                icon: const Icon(Icons.photo),
                label: const Text('Select Image'),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: _upload,
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Upload'),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
