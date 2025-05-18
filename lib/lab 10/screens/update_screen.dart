import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/post.dart';

class UpdateScreen extends StatefulWidget {
  final Post post;
  const UpdateScreen({super.key, required this.post});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController _title;
  late TextEditingController _desc;
  XFile? _picked;
  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.post.title);
    _desc = TextEditingController(text: widget.post.description);
  }

  Future<void> _pick() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) setState(() => _picked = img);
  }

  Future<void> _update() async {
    String url = widget.post.imageUrl;
    if (_picked != null) {
      final file = File(_picked!.path);
      final ref = FirebaseStorage.instance.ref('posts/${widget.post.id}.jpg');
      await ref.putFile(file);
      url = await ref.getDownloadURL();
    }
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.post.id)
        .update({
      'title': _title.text,
      'description': _desc.text,
      'imageUrl': url,
    });
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Edit Post')),
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
          _picked != null
              ? Image.file(File(_picked!.path), height: 150, fit: BoxFit.cover)
              : Image.network(widget.post.imageUrl, height: 150, fit: BoxFit.cover),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _pick,
                icon: const Icon(Icons.photo),
                label: const Text('Change Image'),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: _update,
                icon: const Icon(Icons.save),
                label: const Text('Update'),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
