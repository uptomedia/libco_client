


import 'package:chegg/features/domain/entities/currency_rate_entity.dart';

import '../entities/provider_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/firebase_repository.dart';

class GetCurrencyRateUseCase {

  final FirebaseRepository repository;

  GetCurrencyRateUseCase({required this.repository});

  Future<CurrencyRateEntity> call( String uid){
    return repository.getCurrencyRate(uid);
  }
}