import 'package:dartz/dartz.dart';
import 'package:eden/app/modules/feed/domain/repositories/feed_repository.dart';
import 'package:image_picker/image_picker.dart';

abstract class GalleryPick {
  Future<Either<Exception, PickedFile>> call();
}

class GalleryPickImpl implements GalleryPick {
  final FeedRepository feedRepository;

  GalleryPickImpl(this.feedRepository);

  @override
  Future<Either<Exception, PickedFile>> call() async {
    return feedRepository.galleryPick();
  }
}