


import '../entities/provider_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/firebase_repository.dart';

class GetProfileUseCase {

  final FirebaseRepository repository;

  GetProfileUseCase({required this.repository});

  Future<UserEntity> call( String uid){
    return repository.getProfile(uid);
  }
}