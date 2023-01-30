import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/provider_entity.dart';
import '../../../domain/entities/user_entity.dart';

class CountryModel {
  final String? name;
  final String? imagePath;
  CountryModel({
    this.name,
    this.imagePath,
    })  ;


  factory CountryModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return CountryModel(
      name: documentSnapshot.get('name'),
      imagePath: documentSnapshot.get('imagePath'),
      );
  }

  Map<String, dynamic> toDocument() {
    return {"name": this.name, "imagePath": imagePath};
  }
}
