import 'package:camera/camera.dart';
import 'package:eden/app/modules/feed/presentation/pages/camera_pick/camera_pick_page.dart';
import 'package:eden/app/modules/feed/presentation/pages/feed/feed_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedPage extends StatefulWidget {
  final String uid;

  FeedPage({Key key, @required this.uid}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState(uid);
}

class _FeedPageState extends ModularState<FeedPage, FeedController> {
  final String uid;

  _FeedPageState(this.uid);

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("From where do you want to take the photo?"),
          content: SingleChildScrollView(
            child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      return FutureBuilder(
                        future: controller.galleryPick(context),
                        builder: (ctx, snapshot) {
                          if(snapshot.connectionState == ConnectionState.done) { }
                          return Container();
                        },
                      );
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () async {
                      final cameras = await availableCameras();
                      final camera = cameras.first;
                      var result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CameraPickPage(camera: camera)),
                      );
                    },
                  ),
                ]
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My garden"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSelectionDialog(context);
          //_showSelectionDialog(context).whenComplete(() => Modular.to.pushNamed('/prediction', arguments: {"uid": uid, "image": controller.image}));
        },
        child: Icon(
          Icons.camera_alt
        ),
      ),
    );
  }
}