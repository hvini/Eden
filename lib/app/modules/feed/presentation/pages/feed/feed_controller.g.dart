// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $FeedController = BindInject(
        (i) => FeedController(i<ImagePick>()),
    singleton: true,
    lazy: true
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedController on _FeedController, Store {
  final _$imageAtom = Atom(name: '_FeedController.image');

  @override
  PickedFile get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(PickedFile value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$_FeedControllerActionController =
      ActionController(name: '_FeedController');

  @override
  dynamic setImage(PickedFile value) {
    final _$actionInfo = _$_FeedControllerActionController.startAction(
        name: '_FeedController.setImage');
    try {
      return super.setImage(value);
    } finally {
      _$_FeedControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
