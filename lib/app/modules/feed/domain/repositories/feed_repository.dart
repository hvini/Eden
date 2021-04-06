import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class FeedRepository {
  Future<Either<Exception, PickedFile>> imagePick(ImageSource source);
}