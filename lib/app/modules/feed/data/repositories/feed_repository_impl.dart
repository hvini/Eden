import 'package:dartz/dartz.dart';
import 'package:eden/app/modules/feed/domain/repositories/feed_repository.dart';
import 'package:image_picker/image_picker.dart';

class FeedRepositoryImpl implements FeedRepository {
  @override
  Future<Either<Exception, PickedFile>> imagePick(ImageSource source) async {
    try {
      PickedFile image = await ImagePicker().getImage(source: source);
      if(image == null) return Left(null);
      return Right(image);
    } on Exception catch(ex) {
      return Left(ex);
    }
  }
}