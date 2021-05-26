import 'dart:async';
import 'package:eden/app/modules/feed/presentation/pages/feed/feed_controller.dart';
import 'package:eden/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:asuka/asuka.dart' as asuka;

class FeedPage extends StatefulWidget {
  final String uid;

  FeedPage({@required this.uid});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ModularState<FeedPage, FeedController> {

  Future<bool> _onWillPop() async {
    return false;
  }

  Widget _appBar() {
    return new AppBar(
      title: Text("My garden"),
      leading: new IconButton(
        icon: new Icon(Icons.logout),
        onPressed: () => {  }
      ),
    );
  }

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
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: _appBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () async {
            bool isGallery = await _showSelectionDialog(context);
            if(isGallery != null && isGallery) {
              ImageSource source = ImageSource.gallery;
              try {
                await controller.imagePick(source);
                Modular.to.pushNamed('/prediction', arguments: {"uid": widget.uid, "image": controller.image});
              } on Exception catch(ex) {
                if(ex.toString() != "Exception: null") {
                  asuka.showSnackBar(SnackBar(content: Text(ex.toString())));
                }
                return Container();
              }
            } else if(isGallery != null && !isGallery) {
              ImageSource source = ImageSource.camera;
              try {
                await controller.imagePick(source);
                Modular.to.pushNamed('/prediction', arguments: {"uid": widget.uid, "image": controller.image});
              } on Exception catch(ex) {
                if(ex.toString() != "Exception: null")
                  asuka.showSnackBar(SnackBar(content: Text(ex.toString())));
                return Container();
              }
            }
          },
          child: Icon(
            Icons.camera_alt
          ),
        ),
      )
    );
  }
}