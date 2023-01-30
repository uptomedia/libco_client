import 'package:chegg/features/data/remote/models/countrys_rate_model.dart';
import 'package:chegg/features/data/remote/models/transfer_info_model.dart';
import 'package:chegg/features/domain/entities/currency_rate_entity.dart';
import 'package:chegg/generated/l10n.dart';

import '../entities/exchange_currency_entity.dart';
import '../entities/provider_entity.dart';
import '../entities/transfer_info_entity.dart';
import '../entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<bool> isSignIn();

  Future<void> signIn(UserEntity user);

  Future<void> signUp(UserEntity user);

  Future<void> signOut();

  Future<String> getCurrentUId();

  Future<void> getCreateCurrentUser(UserEntity user);
  Stream<List<ProviderEntity>> getProvider();
  Future<void> addNewProvider(ProviderEntity providerEntity);
  Future<void> updateProvider(ProviderEntity providerEntity);
  Future<void> deleteProvider(ProviderEntity providerEntity);
  Future<void> updateProfile(UserEntity providerEntity);

  Future<UserEntity> getProfile(String uid);
  Future<CurrencyRateEntity> getCurrencyRate(String uid);
  Future<void> addNewTransferInfo(TransferInfoEntity transferInfoEntity);
  Future<void> addNewCountryRate(String subCollectionId,CountrysRatesModel countrysRatesModel);
  Stream<List<TransferInfoEntity>> getTransferInfo();
  Future<void> updateCountryRate(String subCollectionId,String docId,
      CountrysRatesModel countrysRatesModel);
  Future<void> deleteCountryRate(String subCollectionId,String docId,
      CountrysRatesModel countrysRatesModel);

  Stream<List<ExchangeCurrencyEntity>> getExchangeCurrency(String uid);
  Future<void> addNewExchangeCurrency(ExchangeCurrencyEntity uid);

}
