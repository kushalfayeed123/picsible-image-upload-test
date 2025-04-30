import 'dart:io';
import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imagePath;

  const FullScreenImagePage({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: imagePath, // Matching the tag used in GridView
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain, // To ensure image fits properly
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
