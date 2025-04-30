import 'package:permission_handler/permission_handler.dart';

Future<bool> requestStorageAndCameraPermissions() async {
  final camera = await Permission.camera.request();
  final storage = await Permission.photos.request();
  return camera.isGranted && storage.isGranted;
}