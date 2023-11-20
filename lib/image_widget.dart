import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageWidget extends StatelessWidget {
  final File? image;
  final String defaultImagePath;
  final double size;
  final ValueChanged<ImageSource>? onClicked;

  const ImageWidget({
    super.key,
    required this.image,
    required this.defaultImagePath,
    required this.size,
    this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(context),
          Positioned(
            bottom: 0,
            right: 4,
            child: onClicked != null ? buildEditIcon(color) : Container(),
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    if (this.image == null) {
      return ClipOval(
        child: Material(
          color: Colors.white,
          child: SizedBox(
            width: size,
            height: size,
            child: InkWell(
                onTap: () async {
                  if (onClicked != null) {
                    final source = await showImageSource(context);
                    if (source == null) return;

                    onClicked!(source);
                  }
                },
                child: Image.asset(defaultImagePath),
            ),
          ),
        ),
      );
    }

    final imagePath = this.image!.path;
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: size,
          height: size,
          child: InkWell(
              onTap: () async {
                if (onClicked != null) {
                  final source = await showImageSource(context);
                  if (source == null) return;

                  onClicked!(source);
                }
              }
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () => Navigator.of(context).pop(ImageSource.camera),
                  child: const Text('Camera')
              ),
              CupertinoActionSheetAction(
                  onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
                  child: const Text('Gallery')
              )
            ],
          )
      );
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              )
            ],
          )
      );
    }
  }
}
