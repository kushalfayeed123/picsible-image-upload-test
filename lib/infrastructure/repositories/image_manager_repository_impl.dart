import 'dart:convert';
import 'package:flutter_image_upload/domain/models/result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/image_model.dart';
import '../../domain/repositories/image_manager_repository.dart';

class ImageManagerRepositoryImpl implements ImageManagerRepository {
  final ImagePicker _picker = ImagePicker();
  static const _storageKey = 'saved_images';

  @override
  Future<Result<String>> pickImageFromCamera() async {
    try {
      final file = await _picker.pickImage(source: ImageSource.camera);
      if (file == null) {
        return Result.error('No image selected');
      }
      return Result.success(file.path);
    } catch (e) {
      return Result.error('Error picking image from camera: $e');
    }
  }

  @override
  Future<Result<String>> pickImageFromGallery() async {
    try {
      final file = await _picker.pickImage(source: ImageSource.gallery);
      if (file == null) {
        return Result.error('No image selected');
      }
      return Result.success(file.path);
    } catch (e) {
      return Result.error('Error picking image from gallery: $e');
    }
  }

  @override
  Future<Result<List<ImageModel>>> loadSavedImages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);
      if (jsonString == null) return Result.success([]);
      final List decoded = jsonDecode(jsonString);
      return Result.success(
          decoded.map((e) => ImageModel.fromJson(e)).toList());
    } catch (e) {
      return Result.error('Error loading saved images: $e');
    }
  }

  @override
  Future<Result<void>> saveImages(List<ImageModel> images) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(images.map((e) => e.toJson()).toList());
      await prefs.setString(_storageKey, encoded);
      return Result.success(null);
    } catch (e) {
      return Result.error('Error saving images: $e');
    }
  }

  @override
  Future<Result<void>> clearAllImages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
      return Result.success(null);
    } catch (e) {
      return Result.error('Error clearing saved images: $e');
    }
  }
}
