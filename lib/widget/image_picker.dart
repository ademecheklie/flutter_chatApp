import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void Function(File imagePicked) imagePickFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final _picker = ImagePicker();
  File _pickedFile;

  void _pickImage() async {
    final pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 200,
        maxWidth: 200);
    setState(() {
      _pickedFile = File(pickedImage.path);
    });
    widget.imagePickFn(File(pickedImage.path));
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
            backgroundColor: Colors.purple,
            backgroundImage:
                _pickedFile != null ? FileImage(_pickedFile) : null),
        ElevatedButton.icon(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.purple)),
            onPressed: () {
              _pickImage();
            },
            icon: const Icon(
              Icons.image,
            ),
            label: const Text('add image')),
      ],
    );
  }
}
