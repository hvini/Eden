import 'package:eden/app/modules/prediction/data/datasource/firebase_datasource_impl.dart';
import 'package:eden/app/modules/prediction/data/repositories/prediction_repository_impl.dart';
import 'package:eden/app/modules/prediction/domain/usecases/get_all_predictions.dart';
import 'package:eden/app/modules/prediction/domain/usecases/load_model.dart';
import 'package:eden/app/modules/prediction/domain/usecases/prediction.dart';
import 'package:eden/app/modules/prediction/domain/usecases/save_prediction.dart';
import 'package:eden/app/modules/prediction/domain/usecases/upload_file.dart';
import 'package:eden/app/modules/prediction/presentation/pages/prediction/prediction_controller.dart';
import 'package:eden/app/modules/prediction/presentation/pages/prediction/prediction_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PredictionModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => LoadModelImpl(i())),
    Bind((i) => PredictionImpl(i())),
    Bind((i) => SavePredictionImpl(i())),
    Bind((i) => GetAllPredictionsImpl(i())),
    Bind((i) => FirebaseDataSourceImpl()),
    Bind((i) => UploadFileImpl(i())),
    Bind((i) => PredictionRepositoryImpl(i()))
  ];

  List<Bind> export = [
    $PredictionController
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (context, args) => PredictionPage(uid: args.data['uid'], image: args.data['image']))
  ];

}