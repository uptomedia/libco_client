

import 'package:chegg/features/domain/entities/provider_entity.dart';

import '../../data/remote/models/countrys_rate_model.dart';
import '../repositories/firebase_repository.dart';

class UpdateCountryRateUseCase {

  final FirebaseRepository repository;

  UpdateCountryRateUseCase({required this.repository});

  Future<void> call(String subCollectionId,String docId,CountrysRatesModel note)async{
    return repository.updateCountryRate(
      subCollectionId,docId,note
    );
  }
}