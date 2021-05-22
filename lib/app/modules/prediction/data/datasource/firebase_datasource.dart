import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';

abstract class FirebaseDataSource {
  Stream<List<PredictionEntity>> getAllPredictions();
  Future<DocumentReference> savePrediction(PredictionEntity prediction);
  Future<String> uploadFile(File file, String folder, String name, String extension);
  Future<DocumentSnapshot> getPredictionById(String uid);
  Future<void> updatePrediction(String predictionId, Map<String, dynamic> document);
}