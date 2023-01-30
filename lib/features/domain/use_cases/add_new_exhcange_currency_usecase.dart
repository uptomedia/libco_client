





import 'package:chegg/features/domain/entities/exchange_currency_entity.dart';

import '../entities/transfer_info_entity.dart';
import '../repositories/firebase_repository.dart';

class AddNewExchangeCurrencyUseCase {

  final FirebaseRepository repository;

  AddNewExchangeCurrencyUseCase({required this.repository});

  Future<void> call(ExchangeCurrencyEntity note)async{
    return repository.addNewExchangeCurrency(note);
  }
}