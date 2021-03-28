import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class FeedScreen extends StatefulWidget {
  final String uid;

  FeedScreen({Key key, @required this.uid}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState(uid);
}

class _FeedScreenState extends State<FeedScreen> {
  bool _isLoading;
  PickedFile _image;
  List _output;

  final String uid;
  _FeedScreenState(this.uid);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    loadModel().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My garden"),
      ),
      body: _isLoading ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),) : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null ? Container() :  Image.file(File(_image.path)),
            SizedBox(height: 16,),
            _output == null ? Text("") : Text(
              "${_output[0]["label"]}"
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          chooseImage();
        },
        child: Icon(
          Icons.image
        ),
      ),
    );
  }

  chooseImage() async {
    try {
      PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery);
      if(image == null) return;
      setState(() {
        _isLoading = true;
        _image = image;
      });
      runModelOnImage(_image);
    } catch(e) {
      print(e);
    }
  }

  runModelOnImage(PickedFile image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.5
    );
    setState(() {
      _isLoading = false;
      _output = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt"
    );
  }
}