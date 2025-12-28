import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadOptions extends StatelessWidget {
  final Function(ImageSource) onSourceSelected;
  final File? selectedImage;
  final Function() onRemoveImage;

  const UploadOptions({
    super.key,
    required this.onSourceSelected,
    this.selectedImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    // You can move the upload UI components here
    // This makes the UploadScreen cleaner
    return Column(
      children: [
        // Your upload UI here
      ],
    );
  }
}