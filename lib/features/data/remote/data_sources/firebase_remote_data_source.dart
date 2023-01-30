import 'package:chegg/features/data/remote/models/countrys_rate_model.dart';

import '../../../domain/entities/currency_rate_entity.dart';
import '../../../domain/entities/exchange_currency_entity.dart';
import '../../../domain/entities/provider_entity.dart';
import '../../../domain/entities/transfer_info_entity.dart';
import '../../../domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  Future<bool> isSignIn();

  Future<void> signIn(UserEntity user);

  Future<void> signUp(UserEntity user);

  Future<void> signOut();

  Future<String> getCurrentUId();
  Stream<List<ProviderEntity>> getProvider();
  Future<void> addNewProvider(ProviderEntity note);
  Future<void> updateProvider(ProviderEntity note);
  Future<void> deleteProvider(ProviderEntity note);
  Future<void> getCreateCurrentUser(UserEntity user);
  Future<void> updateProfile(UserEntity note);
  Future<UserEntity> getProfile(String uid);
  Future<CurrencyRateEntity> getCurrencyRate(String uid);
  Stream<List<ExchangeCurrencyEntity>> getExchangeCurrency(String uid);
  Future<void> addNewTransferInfo(TransferInfoEntity note);
    Stream<List<TransferInfoEntity>> getTransferInfo();
  Future<void> addNewCountryRate(String subCollection,CountrysRatesModel countrysRatesModel);
  Future<void> updateCountryRate(String subCollection,String docId,CountrysRatesModel countrysRatesModel);
  Future<void> addNewExchangeCurrency(ExchangeCurrencyEntity exchangeCurrencyEntity);

}
