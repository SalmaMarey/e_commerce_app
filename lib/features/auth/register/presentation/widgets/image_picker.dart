// ignore_for_file: file_names

import 'dart:io';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final ValueChanged<File?> onImagePicked;

  const ImagePickerWidget({required this.onImagePicked, super.key});

  @override
    State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
      widget.onImagePicked(selectedImage);
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickImage,
      child: ClipOval(
        child: selectedImage != null
            ? Image.file(
                selectedImage!,
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              )
            : Image.asset(
              Assets.uploadPhoto,
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
