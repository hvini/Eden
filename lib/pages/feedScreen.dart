import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  final String uid;

  FeedScreen({Key key, @required this.uid}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState(uid);
}

class _FeedScreenState extends State<FeedScreen> {
  final String uid;
  _FeedScreenState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Feed",
        ),
      ),
    );
  }
}