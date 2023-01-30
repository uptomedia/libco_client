

import 'package:chegg/features/domain/entities/provider_entity.dart';

import '../repositories/firebase_repository.dart';

class UpdateProviderUseCase {

  final FirebaseRepository repository;

  UpdateProviderUseCase({required this.repository});

  Future<void> call(ProviderEntity note)async{
    return repository.updateProvider(note);
  }
}