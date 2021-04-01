import 'package:dartz/dartz.dart';
import 'package:eden/app/modules/prediction/domain/repositories/prediction_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class PredictionRepositoryImpl implements PredictionRepository {
  @override
  void loadModel() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt"
    );
  }

  @override
  Future<Either<Exception, PickedFile>> galleryPick() async {
    try {
      PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery);
      if(image == null) return Left(null);
      return Right(image);
    } on Exception catch(ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Exception, List<dynamic>>> prediction(PickedFile image) async {
    try {
      List<dynamic> output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.5
      );
      return Right(output);
    } on Exception catch(ex) {
      return Left(ex);
    }
  }
}