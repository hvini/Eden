import 'dart:async';
import 'package:eden/app/modules/feed/presentation/pages/feed/feed_controller.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';
import 'package:eden/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

class FeedPage extends StatefulWidget {
  final String uid;

  FeedPage({@required this.uid});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ModularState<FeedPage, FeedController> {
  ImageSource source;

  @override
  void initState() {
    super.initState();
    controller.setUid(widget.uid);
  }

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
                    setState(() {
                      source = ImageSource.gallery;
                    });
                    Navigator.pop(context, true);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    setState(() {
                      source = ImageSource.camera;
                    });
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
        body: Observer(builder: (_) {
          if(controller.predictionList.data == null) {
            return Container();
          } else if(controller.predictionList.hasError) {
            return Center(
              child: RaisedButton(
                onPressed: () {controller.getList(widget.uid);},
                child: Text('Error'),
              ),
            );
          } else {
            List<PredictionEntity> list = controller.predictionList.data;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                var model = list[index];
                return ListTile(
                  title: Text(model.predicted),
                );
              }
            );
          }
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () async {
            await _showSelectionDialog(context);
            if(source != null) {
              try {
                PickedFile image = await controller.imagePick(source);
                if(image != null) {
                  Modular.to.pushNamed('/prediction', arguments: {"uid": widget.uid, "image": image});
                }
              } on Exception catch(ex) {
                print(ex);
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