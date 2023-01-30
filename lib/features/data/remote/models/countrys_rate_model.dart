import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/provider_entity.dart';
import '../../../domain/entities/user_entity.dart';
import 'country_model.dart';

class CountrysRatesModel {
  final CountryModel? dest;
  final CountryModel? source;
  final double? rate;
  final String? countryRateId;
  CountrysRatesModel({
    this.dest,
    this.source,
    this.rate,
    this.countryRateId
   })  ;


  factory CountrysRatesModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return CountrysRatesModel(
      dest: new CountryModel(name:
      (documentSnapshot.data() as Map)[ 'dest']??
          ""),
      source: new CountryModel( name:
      (documentSnapshot.data() as Map)['source']??
          ""),
      rate: (documentSnapshot.data() as Map)['rate']??0.0,
      countryRateId:
      (documentSnapshot.data() as Map)['countryRateId']??"",
     );
  }

  Map<String, dynamic> toDocument() {
    return {"dest": this.dest!.name??"",
      "source": source!.name??"",
      "rate": rate,
      "countryRateId":countryRateId};
  }
}
