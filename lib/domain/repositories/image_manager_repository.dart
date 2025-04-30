import 'package:flutter_image_upload/domain/models/image_model.dart';
import 'package:flutter_image_upload/domain/models/result.dart';

abstract class ImageManagerRepository {
  Future<Result<String>> pickImageFromCamera();
  Future<Result<String>> pickImageFromGallery();
  Future<Result<List<ImageModel>>> loadSavedImages();
  Future<Result<void>> saveImages(List<ImageModel> images);
  Future<Result<void>> clearAllImages();
}
