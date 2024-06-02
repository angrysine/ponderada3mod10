import 'package:flutter/material.dart';
import 'package:frontend/functions.dart';
import 'package:image_input/image_input.dart';

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({super.key});

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  @override
  Widget build(BuildContext context) {
    return ProfileAvatar(
      radius: 100,
      allowEdit: true,
      backgroundColor: Colors.grey,
      addImageIcon: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.add_a_photo),
        ),
      ),
      removeImageIcon: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.close),
        ),
      ),
      onImageChanged: (XFile? image) {
        //save image to cloud and get the url
        //or
        //save image to local storage and get the path
        String? tempPath = image?.path;
        print(tempPath);
      },
    );
  }
}
