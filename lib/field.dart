import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
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
                          const SizedBox(height: 60),
                          InkWell(
                            onTap: () {
                              setState(() {
                                draggableItems.clear();
                              });
                            },
                            child: const Column(
                              children: [
                                Icon(Icons.delete, color: Colors.white, size: 40),
                                Text("Clear All", style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              onBackButton(context);
                            },
                            child: const Icon(Icons.arrow_back, color: Colors.grey, size: 30,),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Image.asset('assets/images/field/soccer.png', scale: 0.7),
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
                              _createDraggable('assets/images/field/soccer-ball.png'),
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
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              minimumSize: const Size(50, 50),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              backgroundColor: const Color.fromRGBO(86, 94, 109, 1.0),
                            ),
                            onPressed: () async {
                              final image = await controller.capture();
                              if (image == null) return;

                              await saveImage(image).then((value) => onBackButton(context));
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.save),
                                Text(" Save"),
                              ],
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
