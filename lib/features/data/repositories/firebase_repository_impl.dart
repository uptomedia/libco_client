import 'package:chegg/features/domain/entities/currency_rate_entity.dart';

import '../../domain/entities/exchange_currency_entity.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/transfer_info_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/firebase_repository.dart';
import '../remote/data_sources/firebase_remote_data_source.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUId() async => remoteDataSource.getCurrentUId();

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async => remoteDataSource.signUp(user);

  @override
  Stream<List<ProviderEntity>> getProvider() =>
      remoteDataSource.getProvider();

  @override
  Future<void> addNewProvider(ProviderEntity note) async =>
      remoteDataSource.addNewProvider(note);

  @override
  Future<void> deleteProvider(ProviderEntity note) async =>
      remoteDataSource.deleteProvider(note);
  @override
  Future<void> updateNote(ProviderEntity note) async =>
      remoteDataSource.updateProvider(note);

  @override
  Future<void> updateProvider(ProviderEntity note) async =>
      remoteDataSource.updateProvider(note);
  @override
  Future<void> updateProfile(UserEntity note) async =>
      remoteDataSource.updateProfile(note);
  @override
  Future<UserEntity> getProfile(String uid) async =>
      remoteDataSource.getProfile(uid);
  @override
  Future<CurrencyRateEntity> getCurrencyRate(String uid) async =>
      remoteDataSource.getCurrencyRate(uid);


  @override
  Future<void> addNewTransferInfo(TransferInfoEntity transferInfoEntity) async =>
      remoteDataSource.addNewTransferInfo(transferInfoEntity);

  @override
  Stream<List<TransferInfoEntity>> getTransferInfo() =>
      remoteDataSource.getTransferInfo();
  @override
  Stream<List<ExchangeCurrencyEntity>> getExchangeCurrency(String uid)   =>
      remoteDataSource.getExchangeCurrency(uid);

}
