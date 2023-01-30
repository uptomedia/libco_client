

import 'package:chegg/features/domain/entities/provider_entity.dart';

import '../entities/user_entity.dart';
import '../repositories/firebase_repository.dart';

class UpdateProfileUseCase {

  final FirebaseRepository repository;

  UpdateProfileUseCase({required this.repository});

  Future<void> call(UserEntity note)async{
    return repository.updateProfile(note);
  }
}