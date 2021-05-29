import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eden/app/modules/feed/data/datasource/feed_datasource.dart';
import 'package:eden/app/modules/prediction/data/models/prediction_model.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';

class FeedDataSourceImpl implements FeedDataSource {
  FirebaseFirestore firestoreInstance;

  FeedDataSourceImpl({this.firestoreInstance}) {
    this.firestoreInstance = FirebaseFirestore.instance;
  }

  @override
  Stream<List<PredictionEntity>> getUserPredictions(String uid) {
    final predictionCollectionRef = firestoreInstance.collection("predictions").where("user", isEqualTo: uid);
    return predictionCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
        .map((docQuerySnapshot) => PredictionModel.fromSnapshot(docQuerySnapshot))
        .toList();
    });
  }
}