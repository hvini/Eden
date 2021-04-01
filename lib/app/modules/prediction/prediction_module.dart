import 'package:eden/app/modules/prediction/data/repositories/prediction_repository_impl.dart';
import 'package:eden/app/modules/prediction/domain/usecases/gallery_pick.dart';
import 'package:eden/app/modules/prediction/domain/usecases/load_model.dart';
import 'package:eden/app/modules/prediction/domain/usecases/prediction.dart';
import 'package:eden/app/modules/prediction/presentation/pages/prediction/prediction_controller.dart';
import 'package:eden/app/modules/prediction/presentation/pages/prediction/prediction_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PredictionModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => LoadModelImpl(i())),
    Bind((i) => GalleryPickImpl(i())),
    Bind((i) => PredictionImpl(i())),
    Bind((i) => PredictionRepositoryImpl())
  ];

  List<Bind> export = [
    $PredictionController
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/:uid', child: (context, args) => PredictionPage(uid: args.params['uid']))
  ];

}