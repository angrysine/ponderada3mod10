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
  Image? bob;
  Widget build(BuildContext context) {
    return Column(children: [
      ImageInput(
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
          setState(() {
            bob = imageFromBase64String(response);
            createNotification("sua imagem foi processada", "fazol");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Scaffold(
                            body: Column(children: [
                          bob!,
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                            child: const Text('Voltar'),
                          )
                        ]))));
          });
        },
      ),
    ]);
  }
}
