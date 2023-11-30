import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:trainlink/singleton.dart';
import 'package:trainlink/utils.dart';

class Field extends StatefulWidget {
  const Field({Key? key}) : super(key: key);

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  List<DraggableItem> draggableItems = [];
  final controller = ScreenshotController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
        controller: controller,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: backgroundDecoration(),
            child: WillPopScope(
              onWillPop: () async {
                onBackButton(context);
                return false;
              },
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 80),
                          const Row(
                            children: [
                              Icon(Icons.edit, color: Colors.white),
                              Text(" Draw", style: TextStyle(color: Colors.white))
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(Icons.square_rounded, color: Colors.white),
                              Text(" Erase", style: TextStyle(color: Colors.white))
                            ],
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (draggableItems.isNotEmpty) {
                                  draggableItems.removeLast();
                                }
                              });
                            },
                            child: const Column(
                              children: [
                                Icon(Icons.undo, color: Colors.white, size: 30),
                                Text("Undo", style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              setState(() {
                                draggableItems.clear();
                              });
                            },
                            child: const Column(
                              children: [
                                Icon(Icons.delete, color: Colors.white, size: 30),
                                Text("Clear All", style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 80,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      const Color.fromRGBO(24, 231, 114, 1.0)
                                  ),
                              ),
                              onPressed: () {
                                onBackButton(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black54,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Image.asset('assets/images/field/${Singleton().modality.toLowerCase()}.png', scale: 0.7),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 80),
                          Row(
                            children: [
                              _createDraggable('assets/images/field/cone.png'),
                              const Text("  Cone", style: TextStyle(color: Colors.white))
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              _createDraggable('assets/images/field/${Singleton().modality.toLowerCase()}-ball.png'),
                              const Text("  Ball", style: TextStyle(color: Colors.white))
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              _createDraggable('assets/images/field/player-shirt.png'),
                              const Text("  Player", style: TextStyle(color: Colors.white))
                            ],
                          ),
                          const SizedBox(height: 70),
                          SizedBox(
                            width: 110,
                            height: 50,
                            child: ElevatedButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(24, 231, 114, 1.0),
                              ),
                              onPressed: () async {
                                final image = await controller.capture();
                                if (image == null) return;

                                await saveImage(image).then((value) => onBackButton(context));
                              },
                              icon: const Icon(
                                Icons.save,
                                color: Colors.black54,
                              ),
                              label: buttonLabelStyle("Save"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ...draggableItems.map((item) =>
                      item.position.dx > 130 && item.position.dx < 630 && item.position.dy > 40 && item.position.dy < 305 ?
                        Positioned(
                          left: item.position.dx,
                          top: item.position.dy,
                          child: item.image,
                        )
                      : Container()
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }

  void onBackButton(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Navigator.pop(context);
  }

  Widget _createDraggable(String imgPath) {
    return Draggable(
      data: imgPath,
      feedback: Image.asset(imgPath, width: 30, height: 30),
      childWhenDragging:
      Opacity(opacity: 0.3, child: Image.asset(imgPath, width: 30, height: 30)),
      child: Image.asset(imgPath, width: 30, height: 30),
      onDragEnd: (details) {
        setState(() {
          draggableItems.add(
              DraggableItem(position: details.offset, image: Image.asset(imgPath, width: 30, height: 30))
          );
        });
      },
    );
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'screenshot$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }
}

class DraggableItem {
  Offset position;
  Widget image;

  DraggableItem({required this.position, required this.image});
}
