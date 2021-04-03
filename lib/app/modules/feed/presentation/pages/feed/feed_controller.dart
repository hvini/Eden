import 'package:dartz/dartz.dart';
import 'package:eden/app/modules/feed/domain/usecases/gallery_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'feed_controller.g.dart';

@Injectable()
class FeedController = _FeedController with _$FeedController;

abstract class _FeedController with Store {
  final GalleryPick galleryPickUseCase;

  _FeedController(this.galleryPickUseCase);

  Future<PickedFile> galleryPick(BuildContext context) async {
    Either<Exception, PickedFile> image = await galleryPickUseCase();
    image.fold((failure) {
      asuka.showSnackBar(SnackBar(content: Text(failure.toString())));
      return Left(failure);
    }, (PickedFile image) {
      Navigator.of(context).pop();
      setImage(image);
      return Right(image);
    });
  }

  @observable
  PickedFile image;

  @action
  setImage(PickedFile value) => image = value;
}