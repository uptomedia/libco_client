

import '../../data/remote/models/countrys_rate_model.dart';
import '../entities/provider_entity.dart';
import '../repositories/firebase_repository.dart';

class DeleteCountryRateUseCase {

  final FirebaseRepository repository;

  DeleteCountryRateUseCase({required this.repository});

  Future<void> call(String subCollectionId,String docId,CountrysRatesModel note)async{
    return repository.deleteCountryRate(subCollectionId,docId,note);
  }
}