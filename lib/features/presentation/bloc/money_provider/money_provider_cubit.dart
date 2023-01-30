import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chegg/features/data/remote/models/countrys_rate_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/provider_entity.dart';
import '../../../domain/use_cases/add_new_provider_usecase.dart';
import '../../../domain/use_cases/delete_provider_usecase.dart';
import '../../../domain/use_cases/get_provider_usecase.dart';
import '../../../domain/use_cases/update_provider_usecase.dart';

part 'money_provider_state.dart';



class MoneyProviderCubit extends Cubit<MoneyProviderState> {
  final UpdateProviderUseCase updateProviderUseCase;
  final DeleteProviderUseCase deleteProviderUseCase;
  final GetProviderUseCase getProviderUseCase;
  final AddNewProviderUseCase addNewProviderUseCase;
  MoneyProviderCubit({required this.getProviderUseCase,required this.deleteProviderUseCase,
    required this.updateProviderUseCase,required this.addNewProviderUseCase}) : super(MoneyProviderInitial());


  Future<void> addMoneyProvider({required ProviderEntity note})async{
    try{
      await addNewProviderUseCase.call(note);
    }on SocketException catch(_){
      emit(MoneyProviderFailure());
    }catch(_){
      emit(MoneyProviderFailure());
    }
  }

  Future<void> deleteMoneyProvider({required ProviderEntity note})async{
    try{
      await deleteProviderUseCase
      .call(note);
    }on SocketException catch(_){
      emit(MoneyProviderFailure());
    }catch(_){
      emit(MoneyProviderFailure());
    }
  }
  Future<void> updateMoneyProvider({required ProviderEntity note})async{
    try{
      emit(MoneyProviderLoading());

      await updateProviderUseCase.call(note);

    }on SocketException catch(_){
      emit(MoneyProviderFailure());
    }catch(_){
      emit(MoneyProviderFailure());
    }
  }
  Future<void> getMoneyProvider({required String uid})async{
    emit(MoneyProviderLoading());
    try{
      getProviderUseCase.call().listen((notes) {
        emit(MoneyProviderLoaded(notes: notes));
      });
    }on SocketException catch(_){
      emit(MoneyProviderFailure());
    }catch(_){
      emit(MoneyProviderFailure());
    }
  }
Future<List<CountrysRatesModel>> getCountry({required ProviderEntity providerEntity})async{
  List<CountrysRatesModel> allPosts = [];
  emit(MoneyProviderLoading());

  try{
    await providerEntity.countryrate!.first.then((value) =>

    allPosts.addAll(value)
   );
   emit(UpdateProviderLoaded(countryList: allPosts));

  }on SocketException catch(_){
    emit(MoneyProviderFailure());
  }catch(_){
    emit(MoneyProviderFailure());
  }
   return allPosts;
}
}
