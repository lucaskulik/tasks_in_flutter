import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  Function onSelectImage;

  CameraScreen(this.onSelectImage);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraDescription> _cameras;
  CameraController _controller;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  init() async {
    _cameras = await availableCameras();
    _controller = new CameraController(_cameras.first, ResolutionPreset.high);
    _controller.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (_controller == null ||
        _controller.value == null ||
        !_controller.value.isInitialized) return Container();

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withAlpha(100),
              height: 100,
              width: size.width,
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 55,
                ),
                onPressed: () {
                  takePicture(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<String> imagePath() async {
    final temDir = (await getTemporaryDirectory()).path;
    return join(temDir, '${DateTime.now()}.png');
  }

  takePicture(BuildContext context) async {
    String path = await imagePath();
    await _controller.takePicture(path);
    showImage(path, context);
  }

  showImage(String path, BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              child: Image.file(File(path)),
            ),
            actions: [
              TextButton(
                child: Text("Usar Imagem"),
                onPressed: () {
                  File file = File(path);
                  List bytes = file.readAsBytesSync();
                  widget.onSelectImage(base64Encode(bytes));
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancelar"),
              ),
            ],
          );
        });
  }
}
