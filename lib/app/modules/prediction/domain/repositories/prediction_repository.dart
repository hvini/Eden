import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class PredictionRepository {
  void loadModel();
  Future<Either<Exception, List<dynamic>>> prediction(PickedFile image);
}