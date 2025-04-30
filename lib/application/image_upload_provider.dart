import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/image_model.dart';
import '../domain/repositories/image_manager_repository.dart';
import '../infrastructure/repositories/image_manager_repository_impl.dart';

final imageManagerProvider =
    StateNotifierProvider<ImageManagerNotifier, List<ImageModel>>((ref) {
  return ImageManagerNotifier(ImageManagerRepositoryImpl());
});

class ImageManagerNotifier extends StateNotifier<List<ImageModel>> {
  final ImageManagerRepository _repository;
  String? errorMessage;

  ImageManagerNotifier(this._repository) : super([]) {
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      final saved = await _repository.loadSavedImages();
      state = saved.value ?? [];
    } catch (e) {
      errorMessage = "Error loading images: $e";
    }
  }

  Future<void> pickFromCamera() async {
    try {
      final result = await _repository.pickImageFromCamera();
      if (result.isError) {
        errorMessage = result.error;
        return;
      }
      if (result.value == null) {
        errorMessage = "No image selected";
        return;
      }
      if (state.any((img) => img.path == result.value)) {
        errorMessage = "Image already exists";
        return;
      }
      _addImage(result.value!);
      errorMessage = '';
    } catch (e) {
      errorMessage = "Error picking image from camera: $e";
    }
  }

  Future<void> pickFromGallery() async {
    try {
      final result = await _repository.pickImageFromGallery();
      if (result.isError) {
        errorMessage = result.error;
        return;
      }
      if (result.value == null) {
        errorMessage = "No image selected";
        return;
      }
      if (state.any((img) => img.path == result.value)) {
        errorMessage = "Image already exists";
        return;
      }
      _addImage(result.value!);
      errorMessage = '';
    } catch (e) {
      errorMessage = "Error picking image from gallery: $e";
    }
  }

  void _addImage(String path) {
    try {
      final updated = [...state, ImageModel(path: path)];
      state = updated;
      _repository.saveImages(updated);
      errorMessage = '';
    } catch (e) {
      errorMessage = "Error adding image: $e";
    }
  }

  void removeImage(ImageModel image) {
    try {
      final updated = state.where((img) => img.path != image.path).toList();
      state = updated;
      _repository.saveImages(updated);
      errorMessage = '';
    } catch (e) {
      errorMessage = "Error removing image: $e";
    }
  }

  Future<void> clearImages() async {
    try {
      state = [];
      await _repository.clearAllImages();
      errorMessage = '';
    } on Exception catch (e) {
      errorMessage = "Error clearing images: $e";
    }
  }
}
