import 'dart:io';
import 'package:eden/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PreviewPage extends StatefulWidget {
  final List<dynamic> output;
  final PickedFile image;

  PreviewPage({@required this.output, @required this.image});

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  bool liked = false;
  bool disliked = false;

  Future<bool> _onWillPop() async {
    Navigator.of(context).pop(true);
    return true;
  }

  Widget _appBar() {
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: new IconButton(
        icon: new Icon(Icons.close),
        iconSize: 30,
        color: Colors.black,
        onPressed: () => Navigator.of(context).pop()
      ),
    );
  }

  Widget _imageSection(String imagePath) {
    return Expanded(
        flex: 2,
        child: Image.file(File(imagePath), fit: BoxFit.cover)
    );
  }

  Widget _resultTexts(List<dynamic> output) {
    num confidence = output[0]['confidence'] * 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${output[0]['label']}",
          style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Probability: " + confidence.toStringAsFixed(2) + "%",
          style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }

  Widget _feedBackButtons() {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
              liked ? Icons.thumb_up : Icons.thumb_up_outlined,
              color: liked ? Colors.green : Colors.green
          ),
          onPressed: () => setState(() { liked = !liked; }),
        ),
        IconButton(
          icon: Icon(
              disliked ? Icons.thumb_down : Icons.thumb_down_outlined,
              color: disliked ? Colors.red : Colors.red
          ),
          onPressed: () => setState(() { disliked = !disliked; }),
        ),
      ],
    );
  }

  Widget _resultSection(List<dynamic> output) {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            color: primaryColor,
            child: Container(
              alignment: Alignment.topLeft,
              color: primaryColor,
              margin: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              child: Text(
                "Plant predicted",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            color: primaryColor,
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              color: Colors.white,
              height: 80.0,
              margin: new EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
              child: Row(
                children: <Widget>[
                  _resultTexts(output),
                  SizedBox(width: 70.0),
                  _feedBackButtons(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: false,
      bottom: false,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: _appBar(),
          extendBodyBehindAppBar: true,
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _imageSection(widget.image.path),
                _resultSection(widget.output),
              ],
            ),
          ),
        ),
      ),
    );
  }
}