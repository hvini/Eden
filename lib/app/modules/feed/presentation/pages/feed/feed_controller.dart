import 'package:eden/app/modules/feed/domain/usecases/image_pick.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'feed_controller.g.dart';

@Injectable()
class FeedController = _FeedController with _$FeedController;

abstract class _FeedController with Store {
  final ImagePick imagePickUseCase;

  _FeedController(this.imagePickUseCase);

  Future<void> imagePick(ImageSource source) async {
    await imagePickUseCase(source).then((response) {
      response.fold(
        (failure) {
          throw new Exception(failure.toString());
        }, (PickedFile image) {
          setImage(image);
        }
      );
      return null;
    });
    return null;
  }

  @observable
  PickedFile image;

  @action
  setImage(PickedFile value) => image = value;
}