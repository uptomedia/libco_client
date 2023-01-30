import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chegg/features/domain/use_cases/add_new_transfer_info_usecase.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/transfer_info_entity.dart';
import '../../../domain/use_cases/get_transfer_info_usecase.dart';

part 'transfer_info_state.dart';

class TransferInfoCubit extends Cubit<TransferInfoState> {
   final AddNewTransferInfoUseCase addNewTransferInfoUseCase;
   final GetTransferInfoUseCase getTransferInfoUseCase;

   TransferInfoCubit({
  required this.addNewTransferInfoUseCase, required this.getTransferInfoUseCase}) : super(TransferInfoInitial());
   Future<void> addTransferInfo({required TransferInfoEntity note})async{
     emit(TransferInfoLoading());

     try{
       await addNewTransferInfoUseCase.call(note);
       emit(AddNewTransferInfoLoaded());

     }on SocketException catch(_){
       emit(TransferInfoFailure());
     }catch(_){
       emit(TransferInfoFailure());
     }
   }
   Future<void> getTransferInfo({required String uid})async{
     emit(TransferInfoLoading());
     try{
       getTransferInfoUseCase.call().listen((notes) {
         emit(TransferInfoLoaded(tranferList: notes));
       });
     }on SocketException catch(_){
       emit(TransferInfoFailure());
     }catch(_){
       emit(TransferInfoFailure());
     }
   }

  }
