//task 1 

import 'package:flutter/material.dart';

void main() {
  runApp(ImageGridApp());
}

class ImageGridApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Grid Layout',
      home: ImageGridScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ImageGridScreen extends StatelessWidget {
  final List<String> imageUrls = [
    'https://picsum.photos/id/237/300/300',
    'https://picsum.photos/id/238/300/300',
    'https://picsum.photos/id/239/300/300',
    'https://picsum.photos/id/240/300/300',
    'https://picsum.photos/id/241/300/300',
    'https://picsum.photos/id/242/300/300',
    'https://picsum.photos/id/243/300/300',
    'https://picsum.photos/id/244/300/300',
    'https://picsum.photos/id/245/300/300',
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate number of columns based on screen width
    int crossAxisCount = (screenWidth / 150).floor();

    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Image Grid'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: imageUrls.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
