import 'dart:async';
import 'package:eden/app/modules/feed/presentation/pages/feed/feed_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

class FeedPage extends StatefulWidget {
  final String uid;

  FeedPage({Key key, @required this.uid}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ModularState<FeedPage, FeedController> {
  bool requestIsInAction;

  Future<bool> _showSelectionDialog(BuildContext context) {
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
                    Navigator.pop(context, true);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
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
        onPressed: () async {
          bool val = await _showSelectionDialog(context);
          if(val != null && val) {
            controller.galleryPick(context).whenComplete(() => {
              Modular.to.pushNamed('/prediction', arguments: {"uid": widget.uid, "image": controller.image})
            });
          } else if(val != null && !val) {
            PickedFile img = await ImagePicker().getImage(source: ImageSource.camera);
            Modular.to.pushNamed('/prediction', arguments: {"uid": widget.uid, "image": img});
          }
        },
        child: Icon(
          Icons.camera_alt
        ),
      ),
    );
  }
}