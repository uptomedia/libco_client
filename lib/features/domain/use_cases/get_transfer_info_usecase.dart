


import '../entities/provider_entity.dart';
import '../entities/transfer_info_entity.dart';
import '../repositories/firebase_repository.dart';

class GetTransferInfoUseCase {

  final FirebaseRepository repository;

  GetTransferInfoUseCase({required this.repository});

  Stream<List<TransferInfoEntity>> call(){
    return repository.getTransferInfo();
  }
}