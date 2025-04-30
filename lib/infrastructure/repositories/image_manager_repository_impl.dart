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
      if (file != null) {
        return Result.success(file.path);
      } else {
        return Result.error("No image selected");
      }
    } catch (e) {
      return Result.error("Error picking image from camera: $e");
    }
  }

  @override
  Future<Result<String>> pickImageFromGallery() async {
    try {
      final file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        return Result.success(file.path);
      } else {
        return Result.error("No image selected");
      }
    } catch (e) {
      return Result.error("Error picking image from gallery: $e");
    }
  }

  @override
  Future<List<ImageModel>> loadSavedImages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString == null) return [];
    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => ImageModel.fromJson(e)).toList();
  }

  @override
  Future<void> saveImages(List<ImageModel> images) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(images.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  @override
  Future<void> clearAllImages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
