import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chegg/features/domain/entities/currency_rate_entity.dart';
import 'package:chegg/features/domain/entities/exchange_currency_entity.dart';
import 'package:chegg/features/domain/use_cases/get_currency_rate_usecase.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../../data/remote/models/currency_model.dart';
 import '../../../domain/use_cases/get_exhange_currency_usecase.dart';

part 'exchange_currency_state.dart';

class ExchangeCurrencyCubit extends Cubit<ExchangeCurrencyState> {
  ExchangeCurrencyCubit(
  {
    required this.getExchangeCurrencyUseCase,
 }

      ) : super(ExchangeCurrencyInitial());
  GetExchangeCurrencyUseCase getExchangeCurrencyUseCase;
   Future<void> getExchangeCurrency({
    required String code})async{
      List<ExchangeCurrencyEntity> exchangeList=[];


     emit(ExchangeCurrencyLoading());
     try{
         await getExchangeCurrencyUseCase.call(code).listen((exchangeCurrencyEntity) async {
            emit(ExchangeCurrencyLoaded(exchangeCurrencyModel: exchangeCurrencyEntity));
         });

         //
      //     allPosts.addAll(value)
      // );

    }on SocketException catch(_){
      emit(ExchangeCurrencyFailure());
    }catch(_){
      emit(ExchangeCurrencyFailure());
    }

  }


}
