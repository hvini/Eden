import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eden/app/modules/feed/data/datasource/feed_datasource.dart';
import 'package:eden/app/modules/prediction/data/models/prediction_model.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedDataSourceImpl implements FeedDataSource {
  FirebaseFirestore firestoreInstance;
  FirebaseAuth authInstance;

  FeedDataSourceImpl({this.firestoreInstance, this.authInstance}) {
    this.firestoreInstance = FirebaseFirestore.instance;
    this.authInstance = FirebaseAuth.instance;
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

  @override
  Future<void> signOut() async {
    if(authInstance.currentUser != null) {
      await authInstance.signOut();
    } else {
      throw new Exception("Is already signed out!");
    }
  }
}