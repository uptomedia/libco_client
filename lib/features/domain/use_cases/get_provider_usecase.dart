


import '../entities/provider_entity.dart';
import '../repositories/firebase_repository.dart';

class GetProviderUseCase {

  final FirebaseRepository repository;

  GetProviderUseCase({required this.repository});

  Stream<List<ProviderEntity>> call(){
    return repository.getProvider();
  }
}