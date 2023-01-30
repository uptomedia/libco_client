import 'package:equatable/equatable.dart';

import '../../data/remote/models/countrys_rate_model.dart';

class ProviderEntity extends Equatable {
  final String? name;
  final String? imagePath;
  final String? providerId;
  final  Stream<List<CountrysRatesModel>>? countryrate;


  ProviderEntity({
    this.name,
    this.imagePath,
    this.providerId,
    this.countryrate

  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
    imagePath,
     providerId,
    countryrate
       ];
}
