import 'package:dartz/dartz.dart';
import 'package:eden/app/modules/prediction/domain/repositories/prediction_repository.dart';
import 'package:image_picker/image_picker.dart';

abstract class GalleryPick {
  Future<Either<Exception, PickedFile>> call();
}

class GalleryPickImpl implements GalleryPick {
  final PredictionRepository predictionRepository;

  GalleryPickImpl(this.predictionRepository);

  @override
  Future<Either<Exception, PickedFile>> call() async {
    return predictionRepository.galleryPick();
  }
}