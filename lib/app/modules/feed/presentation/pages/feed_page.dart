import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedPage extends StatefulWidget {
  final String uid;

  FeedPage({Key key, @required this.uid}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState(uid);
}

class _FeedPageState extends State<FeedPage> {
  final String uid;
  _FeedPageState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My garden"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('/prediction/' + uid);
        },
        child: Icon(
          Icons.image
        ),
      ),
    );
  }
}