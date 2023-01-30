import '../entities/transfer_info_entity.dart';
 import '../repositories/firebase_repository.dart';

 class AddNewTransferInfoUseCase {

   final FirebaseRepository repository;

   AddNewTransferInfoUseCase({required this.repository});

   Future<void> call(TransferInfoEntity note)async{
     return repository.addNewTransferInfo(note);
   }
 }