import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chegg/features/domain/entities/currency_rate_entity.dart';
import 'package:chegg/features/domain/use_cases/get_currency_rate_usecase.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../../data/remote/models/currency_model.dart';

part 'currency_rate_state.dart';

class CurrencyRateCubit extends Cubit<CurrencyRateState> {
  CurrencyRateCubit(
  {
    required this.getCurrencyRateUseCase
}

      ) : super(CurrencyRateInitial());


  GetCurrencyRateUseCase getCurrencyRateUseCase;
  Future<void> getCurrencyRate({
    required String code})async{
     emit(CurrencyRateLoading());
     CurrencyRateEntity currencyRateEntity;
    try{
      currencyRateEntity=
        await getCurrencyRateUseCase.call(code);       //
      //     allPosts.addAll(value)
      // );
      emit(CurrencyRateLoaded(currencyRateModel: currencyRateEntity));

    }on SocketException catch(_){
      emit(CurrencyRateFailure());
    }catch(_){
      emit(CurrencyRateFailure());
    }

  }

}
