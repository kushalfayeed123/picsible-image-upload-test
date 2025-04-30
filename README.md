# Image Upload App

This app allows users to upload images from the camera or gallery and display them in a sleek, responsive grid. Users can also view images in full screen, remove individual images, and clear all images. The app uses `Riverpod` for state management and `SharedPreferences` for persistent storage.

## Features:
- Upload images from camera or gallery
- View images in full screen with smooth animation
- Remove individual images from the grid
- Clear all images
- Persist images locally using `SharedPreferences`

## Dependencies

Ensure you have the following dependencies in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
    image_picker: ^1.1.2
  permission_handler: ^12.0.0+1
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.3.3
  shared_preferences: ^2.5.3


Setup Instructions
1. Install Flutter
Ensure you have Flutter installed. You can download and install it from the official site: Flutter Installation

2. Install Dependencies
Run the following command to install the required dependencies:
flutter pub get


3. Add Permissions
To allow the app to access the camera and gallery, add the following permissions:

Android: Open android/app/src/main/AndroidManifest.xml and add the following permissions:
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>


iOS: Open ios/Runner/Info.plist and add the following keys for permissions:
<key>NSCameraUsageDescription</key>
<string>We need access to your camera for capturing images.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library for selecting images.</string>


4. Running the App
Run the app using the following command:
flutter run
This will start the app on your connected device or simulator.

5. Debugging
If you encounter any issues, ensure the following:

You have set up your environment and dependencies correctly.

The required permissions for camera and gallery access are granted.

You have the latest version of Flutter installed.

Folder Structure
Here’s a breakdown of the main files and directories in the project:

lib/
├── application/
│   └── image_manager_provider.dart  # Manages image-related state and logic with Riverpod
├── core/utils
│   └── permission_handler.dart  # Manages image-related state and logic with Riverpod
├── domain/
│   ├── models/
│   │   └── image_model.dart        # Defines Image Model
│   │   └── result.dart             # Defines Result Model
│   └── repositories/
│       └── image_manager_repository.dart  # Image repository interface
├── infrastructure/
│   └── repositories/
│       └── image_manager_repository_impl.dart  # Implementation of the image repository
└── presentation/pages
    ├── image_upload_page.dart      # Main screen for uploading and displaying images
    └── full_screen_image_page.dart # Full-screen view of images


Project Overview
This project is built using Flutter and Riverpod for state management. It allows users to upload images, view them in full screen, and manage images (remove or clear all). The app saves the images locally using SharedPreferences.

Image Upload: Users can pick images from the camera or gallery.

Image Display: The images are displayed in a grid layout using GridView.builder for better performance when loading a large number of images.

Full Screen Image: Users can view images in full screen using the Hero widget.

State Management: The app uses Riverpod to manage state and handle side effects.

Persistence: The app persists the list of images using SharedPreferences to store the file paths locally.






