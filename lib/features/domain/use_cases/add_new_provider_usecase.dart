


import '../entities/provider_entity.dart';
import '../repositories/firebase_repository.dart';

class AddNewProviderUseCase {

  final FirebaseRepository repository;

  AddNewProviderUseCase({required this.repository});

  Future<void> call(ProviderEntity note)async{
    return repository.addNewProvider(note);
  }
}