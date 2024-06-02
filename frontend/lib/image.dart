import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';
import "package:frontend/functions.dart";
import 'dart:io';

class ImageProcesser extends StatefulWidget {
  const ImageProcesser({super.key});

  @override
  State<ImageProcesser> createState() => _ImageProcesserState();
}

class _ImageProcesserState extends State<ImageProcesser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ImageInput(
        allowEdit: true,
        allowMaxImage: 5,
        onImageSelected: (image, index) async {
          //save image to cloud and get the url
          //or
          //save image to local storage and get the path
          String? tempPath = image.path;
          var response =
              await sendImage(File(image.path), await getTokenFromStorage());
          print(response);
        },
      ),
    );
  }
}
