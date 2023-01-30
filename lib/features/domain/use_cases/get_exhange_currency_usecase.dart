



import '../entities/exchange_currency_entity.dart';
  import '../repositories/firebase_repository.dart';

class GetExchangeCurrencyUseCase {

  final FirebaseRepository repository;

  GetExchangeCurrencyUseCase({required this.repository});

  Stream<List<ExchangeCurrencyEntity>> call( String uid){
    return repository.getExchangeCurrency(uid);
  }
}