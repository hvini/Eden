// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $FeedController = BindInject(
        (i) => FeedController(i<ImagePick>(), i<GetUserPredictions>()),
    singleton: true,
    lazy: true
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedController on _FeedController, Store {
  final _$uidAtom = Atom(name: '_FeedController.uid');

  @override
  String get uid {
    _$uidAtom.reportRead();
    return super.uid;
  }

  @override
  set uid(String value) {
    _$uidAtom.reportWrite(value, super.uid, () {
      super.uid = value;
    });
  }

  final _$predictionListAtom = Atom(name: '_FeedController.predictionList');

  @override
  ObservableStream<List<PredictionEntity>> get predictionList {
    _$predictionListAtom.reportRead();
    return super.predictionList;
  }

  @override
  set predictionList(ObservableStream<List<PredictionEntity>> value) {
    _$predictionListAtom.reportWrite(value, super.predictionList, () {
      super.predictionList = value;
    });
  }

  final _$_FeedControllerActionController =
      ActionController(name: '_FeedController');

  @override
  dynamic setUid(String value) {
    final _$actionInfo = _$_FeedControllerActionController.startAction(
        name: '_FeedController.setUid');
    try {
      return super.setUid(value);
    } finally {
      _$_FeedControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getList(String uid) {
    final _$actionInfo = _$_FeedControllerActionController.startAction(
        name: '_FeedController.getList');
    try {
      return super.getList(uid);
    } finally {
      _$_FeedControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
uid: ${uid},
predictionList: ${predictionList}
    ''';
  }
}
