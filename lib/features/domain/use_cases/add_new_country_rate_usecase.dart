


 import '../../data/remote/models/countrys_rate_model.dart';
import '../entities/transfer_info_entity.dart';
import '../repositories/firebase_repository.dart';

class AddNewCountryRateUseCase {

  final FirebaseRepository repository;

  AddNewCountryRateUseCase({required this.repository});

  Future<void> call(String subcollectionId,CountrysRatesModel note)async{
    return repository.addNewCountryRate(subcollectionId,note);
  }
}