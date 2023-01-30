import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chegg/features/data/remote/models/countrys_rate_model.dart';
import 'package:chegg/features/domain/use_cases/add_new_country_rate_usecase.dart';
import 'package:chegg/features/domain/use_cases/update_country_rate_usecase.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/provider_entity.dart';
import '../../../domain/use_cases/add_new_provider_usecase.dart';
import '../../../domain/use_cases/delete_country_rate_usecase.dart';
import '../../../domain/use_cases/delete_provider_usecase.dart';
import '../../../domain/use_cases/get_provider_usecase.dart';
import '../../../domain/use_cases/update_provider_usecase.dart';

part 'money_provider_state.dart';



class MoneyProviderCubit extends Cubit<MoneyProviderState> {
  final UpdateProviderUseCase updateProviderUseCase;
  final DeleteProviderUseCase deleteProviderUseCase;
  final GetProviderUseCase getProviderUseCase;
  final AddNewProviderUseCase addNewProviderUseCase;
  final AddNewCountryRateUseCase addNewCountryRateUseCase;
  final UpdateCountryRateUseCase updateCountryRateUseCase;
  final DeleteCountryRateUseCase deleteCountryRateUseCase;

  MoneyProviderCubit({required this.getProviderUseCase,required this.deleteProviderUseCase,
    required this.updateProviderUseCase,
    required this.addNewProviderUseCase,required this.addNewCountryRateUseCase,
  required this.updateCountryRateUseCase,
  required this.deleteCountryRateUseCase}) : super(MoneyProviderInitial());


  Future<void> addMoneyProvider({required ProviderEntity note})async{
    try{
      emit(MoneyProviderLoading());

      await addNewProviderUseCase.call(note);
      emit(AddMoneyProviderLoaded());

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
  Future<void> addCountryRateProvider({required String subCollectionId,required CountrysRatesModel countrysRatesModel})async{
    try{
      emit(MoneyProviderLoading());

      await addNewCountryRateUseCase.call(
          subCollectionId,countrysRatesModel);
      emit(AddCountryRateLoaded());

    }on SocketException catch(_){
      emit(MoneyProviderFailure());
    }catch(_){
      emit(MoneyProviderFailure());
    }
  }
  Future<void> updateCountryRateProvider({
    required String subCollectionId,
    required String docId,
    required CountrysRatesModel countrysRatesModel})async{
    try{
      emit(MoneyProviderLoading());

      await updateCountryRateUseCase.call(
          subCollectionId,docId,countrysRatesModel);
      emit(UpdateCountryRateLoaded());

    }on SocketException catch(_){
      emit(MoneyProviderFailure());
    }catch(_){
      emit(MoneyProviderFailure());
    }
  }
Future<void> deleteCountryRateProvider({
    required String subCollectionId,
    required String docId,
    required CountrysRatesModel countrysRatesModel})async{
    try{
      emit(MoneyProviderLoading());

      await deleteCountryRateUseCase.call(
          subCollectionId,docId,countrysRatesModel);
      emit(DeleteCountryRateLoaded());

    }on SocketException catch(_){
      emit(MoneyProviderFailure());
    }catch(_){
      emit(MoneyProviderFailure());
    }
  }
}
