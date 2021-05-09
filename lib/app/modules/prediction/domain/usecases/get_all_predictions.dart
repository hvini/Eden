import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';
import 'package:eden/app/modules/prediction/domain/repositories/prediction_repository.dart';

abstract class GetAllPredictions {
  Stream<List<PredictionEntity>> call();
}

class GetAllPredictionsImpl implements GetAllPredictions {
  final PredictionRepository predictionRepository;

  GetAllPredictionsImpl(this.predictionRepository);

  @override
  Stream<List<PredictionEntity>> call() {
    return predictionRepository.getAllPredictions();
  }
}