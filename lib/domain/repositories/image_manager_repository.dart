import 'package:flutter_image_upload/domain/models/result.dart';

import '../../domain/models/image_model.dart';

abstract class ImageManagerRepository {
  Future<Result<String>> pickImageFromCamera();
  Future<Result<String>> pickImageFromGallery();
  Future<List<ImageModel>> loadSavedImages();
  Future<void> saveImages(List<ImageModel> images);
  Future<void> clearAllImages();
}
