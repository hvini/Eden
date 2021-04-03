import 'package:camera/camera.dart';
import 'package:eden/app/modules/feed/presentation/pages/camera_preview/camera_preview_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraPickPage extends StatefulWidget {
  final CameraDescription camera;

  CameraPickPage({@required this.camera});

  @override
  _CameraPickPageState createState() => _CameraPickPageState();
}

class _CameraPickPageState extends State<CameraPickPage> {
  CameraController _controller;
  Future<void> _initializeCameraController;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _initializeCameraController = _controller.initialize();
  }

  Widget _cameraPreviewWidget() {
    return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: CameraPreview(_controller)
    );
  }

  Widget _cameraControlWidget(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(
                Icons.camera,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              onPressed: () {
                _onCapturePressed(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onCapturePressed(context) async {
    try {
      final path = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
      await _controller.takePicture(path);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraPreviewPage(
            imgPath: path
        )),
      );
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      FutureBuilder(
        future: _initializeCameraController,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: _cameraPreviewWidget()
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          color: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              _cameraControlWidget(context),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
            );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    ]);
  }
}