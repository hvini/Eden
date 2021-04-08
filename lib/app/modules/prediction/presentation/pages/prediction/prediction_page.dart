import 'package:eden/app/modules/prediction/presentation/pages/prediction/prediction_controller.dart';
import 'package:eden/app/modules/prediction/presentation/pages/preview/preview_page.dart';
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
  _PredictionPageState createState() => _PredictionPageState(uid);
}

class _PredictionPageState extends ModularState<PredictionPage, PredictionController> {
  final String uid;

  _PredictionPageState(this.uid);

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
                  future: controller.prediction(widget.image),
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
                return PreviewPage(output: state.list, image: widget.image);
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