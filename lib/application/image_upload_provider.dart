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

  ImageManagerNotifier(this._repository) : super([]) {
    _loadImages();
  }

  Future<void> _loadImages() async {
    final saved = await _repository.loadSavedImages();
    state = saved;
  }

  Future<void> pickFromCamera() async {
    final result = await _repository.pickImageFromCamera();
    if (result.isSuccess) {
      _addImage(result.value!);
    } else {
      _showError(result.error!);
    }
  }

  Future<void> pickFromGallery() async {
    final result = await _repository.pickImageFromGallery();
    if (result.isSuccess) {
      _addImage(result.value!);
    } else {
      _showError(result.error!);
    }
  }

  void _addImage(String path) {
    final updated = [...state, ImageModel(path: path)];
    state = updated;
    _repository.saveImages(updated);
  }

  void removeImage(ImageModel image) {
    final updated = state.where((img) => img.path != image.path).toList();
    state = updated;
    _repository.saveImages(updated);
  }

  Future<void> clearImages() async {
    state = [];
    await _repository.clearAllImages();
  }

  void _showError(String message) {
    // Implement your error handling here, such as showing a dialog or snackbar
    print("Error: $message");
  }
}
