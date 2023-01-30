

import '../entities/provider_entity.dart';
import '../repositories/firebase_repository.dart';

class DeleteProviderUseCase {

  final FirebaseRepository repository;

  DeleteProviderUseCase({required this.repository});

  Future<void> call(ProviderEntity note)async{
    return repository.deleteProvider(note);
  }
}