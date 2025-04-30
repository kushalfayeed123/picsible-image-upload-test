class ImageModel {
  final String path;

  ImageModel({required this.path});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(path: json['path']);
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
    };
  }
}
