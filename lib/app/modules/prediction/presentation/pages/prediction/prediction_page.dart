import 'dart:io';
import 'package:eden/app/modules/prediction/presentation/pages/prediction/prediction_controller.dart';
import 'package:eden/app/modules/prediction/presentation/states/prediction_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

class PredictionPage extends StatefulWidget {
  final String uid;
  final PickedFile image;
  
  PredictionPage({Key key, @required this.uid, @required this.image}) : super(key: key);
  
  @override
  _PredictionPageState createState() => _PredictionPageState(uid, image);
}

class _PredictionPageState extends ModularState<PredictionPage, PredictionController> {
  final String uid;
  PickedFile image;
  
  _PredictionPageState(this.uid, this.image);

  Widget _buildPreview(List<dynamic> output) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          image == null ? Container() : Image.file(File(image.path)),
          SizedBox(height: 16,),
          output[0]['label'] == null ? Text("") : Text(
            "${output[0]["label"]}"
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Observer(builder: (_) {
              var state = controller.state;
              if(state is StartState) {
                return FutureBuilder(
                  future: controller.prediction(image),
                  builder: (ctx, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator()
                      );
                    }
                    return controller.setState(SuccessState(snapshot.data()));
                  },
                );
              } else if(state is SuccessState) {
                return _buildPreview(state.list);
              } else {
                return Container();
              }
            }),
          ),
        ],
      ),
    );
  }
}