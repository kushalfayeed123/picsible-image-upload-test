import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_upload/presentation/pages/full_screen_image_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/image_upload_provider.dart';

class ImageUploadPage extends ConsumerWidget {
  const ImageUploadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(imageManagerProvider);
    final controller = ref.read(imageManagerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Upload"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await controller.clearImages();
              _showError(context, "All images have been cleared.");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  await controller.pickFromCamera();
                  if (controller.errorMessage != null &&
                      controller.errorMessage!.isNotEmpty) {
                    _showError(context, controller.errorMessage!);
                  }
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Camera"),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  await controller.pickFromGallery();
                  if (controller.errorMessage != null &&
                      controller.errorMessage!.isNotEmpty) {
                    _showError(context, controller.errorMessage!);
                  }
                },
                icon: const Icon(Icons.photo),
                label: const Text("Gallery"),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: images.isEmpty
                ? const Center(child: Text("No images uploaded"))
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final image = images[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  FullScreenImagePage(imagePath: image.path),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Hero(
                              tag: image.path,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(image.path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 4,
                              top: 4,
                              child: InkWell(
                                onTap: () => controller.removeImage(image),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    // Show a snackbar with the error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
