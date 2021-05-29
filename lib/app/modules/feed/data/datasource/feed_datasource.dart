import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';

abstract class FeedDataSource {
  Stream<List<PredictionEntity>> getUserPredictions(String uid);
}