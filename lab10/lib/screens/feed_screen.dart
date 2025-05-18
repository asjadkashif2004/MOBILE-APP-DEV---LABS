import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../model/post.dart';
import 'upload_screen.dart';
import 'update_screen.dart';
import 'package:http/http.dart' as http;

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  Future<void> _download(BuildContext ctx, Post p) async {
    if (await Permission.storage.request().isGranted) {
      final bytes = await http.readBytes(Uri.parse(p.imageUrl));
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/${p.id}.jpg');
      await file.writeAsBytes(bytes);
      // Removed ctx.mounted check because BuildContext has no mounted property
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('Image downloaded successfully!')),
      );
    }
  }

  Future<void> _delete(BuildContext ctx, Post p) async {
    final ok = await showDialog<bool>(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('Delete post?'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('No')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Yes')),
        ],
      ),
    ) ?? false;
    if (!ok) return;
    await FirebaseFirestore.instance.collection('posts').doc(p.id).delete();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Feed')),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (c, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        final posts = snap.data!.docs
            .map((d) => Post.fromJson(d.id, d.data()))
            .toList();
        if (posts.isEmpty) return const Center(child: Text('No posts yet.'));
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (c, i) {
            final p = posts[i];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: GestureDetector(
                  onLongPress: () => _download(c, p),
                  child: Image.network(p.imageUrl, width: 56, height: 56, fit: BoxFit.cover),
                ),
                title: Text(p.title),
                subtitle: Text(p.description),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => Navigator.push(
                      c,
                      MaterialPageRoute(builder: (_) => UpdateScreen(post: p)),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _delete(c, p),
                  ),
                ]),
              ),
            );
          },
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, UploadScreen.route),
      child: const Icon(Icons.add),
    ),
  );
}
