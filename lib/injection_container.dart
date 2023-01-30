import 'package:chegg/core/platform/network_info.dart';
import 'package:chegg/features/domain/use_cases/add_new_country_rate_usecase.dart';
import 'package:chegg/features/domain/use_cases/add_new_exhcange_currency_usecase.dart';
import 'package:chegg/features/domain/use_cases/add_new_provider_usecase.dart';
import 'package:chegg/features/domain/use_cases/delete_country_rate_usecase.dart';
import 'package:chegg/features/domain/use_cases/get_currency_rate_usecase.dart';
import 'package:chegg/features/domain/use_cases/get_exhange_currency_usecase.dart';
import 'package:chegg/features/domain/use_cases/get_profile_usecase.dart';
import 'package:chegg/features/domain/use_cases/update_country_rate_usecase.dart';
import 'package:chegg/features/domain/use_cases/update_profile_usecase.dart';
import 'package:chegg/features/presentation/bloc/currency_rate/currency_rate_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'core/app/state/appstate.dart';
import 'features/data/remote/data_sources/firebase_remote_data_source.dart';
import 'features/data/remote/data_sources/firebase_remote_data_source_impl.dart';
import 'features/data/repositories/firebase_repository_impl.dart';
import 'features/domain/repositories/firebase_repository.dart';
import 'features/domain/use_cases/add_new_transfer_info_usecase.dart';
import 'features/domain/use_cases/delete_provider_usecase.dart';
import 'features/domain/use_cases/get_create_current_user_usecase.dart';
import 'features/domain/use_cases/get_current_uid_usecase.dart';
import 'features/domain/use_cases/get_provider_usecase.dart';
import 'features/domain/use_cases/get_transfer_info_usecase.dart';
import 'features/domain/use_cases/is_sign_in_usecase.dart';
import 'features/domain/use_cases/sign_in_usecase.dart';
import 'features/domain/use_cases/sign_out_usecase.dart';
import 'features/domain/use_cases/sign_up_usecase.dart';
import 'features/domain/use_cases/update_provider_usecase.dart';
import 'features/presentation/bloc/auth/auth_cubit.dart';
import 'features/presentation/bloc/exchange_currency/exchange_currency_cubit.dart';
import 'features/presentation/bloc/money_provider/money_provider_cubit.dart';
import 'features/presentation/bloc/tranfer_info/transfer_info_cubit.dart';
import 'features/presentation/bloc/user/user_cubit.dart';


 GetIt sl = GetIt.instance;
Future<void>
 init(prefs)  async {
  //Cubit/Bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      getCurrentUidUseCase: sl.call()));
  sl.registerFactory<UserCubit>(() => UserCubit(
        getCreateCurrentUserUseCase: sl.call(),
        signInUseCase: sl.call(),
        signUPUseCase: sl.call(), getProfile: sl.call(),
   updateProfile: sl.call(),
      ));
  sl.registerFactory<MoneyProviderCubit>(() => MoneyProviderCubit(
      deleteProviderUseCase: sl.call(),
      addNewProviderUseCase: sl.call(),
      updateProviderUseCase: sl.call(),
      getProviderUseCase: sl.call(),
      addNewCountryRateUseCase: sl.call(),
   updateCountryRateUseCase: sl.call(),
   deleteCountryRateUseCase: sl.call()

  ));
  sl.registerFactory<ExchangeCurrencyCubit>(() => ExchangeCurrencyCubit(
    addNewExchangeCurrencyUseCase: sl.call(),
      getExchangeCurrencyUseCase: sl.call()

  ));
  sl.registerFactory<TransferInfoCubit>(() => TransferInfoCubit(
   addNewTransferInfoUseCase: sl.call(),
   getTransferInfoUseCase: sl.call()

  ));
  sl.registerFactory<CurrencyRateCubit>(() => CurrencyRateCubit(
     getCurrencyRateUseCase: sl.call(),

  ));
  sl.registerLazySingleton<GetProviderUseCase>(
          () => GetProviderUseCase(repository: sl.call()));
  sl.registerLazySingleton<AddNewProviderUseCase>(
          () => AddNewProviderUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateProviderUseCase>(
          () => UpdateProviderUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteProviderUseCase>(
          () => DeleteProviderUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetProfileUseCase>(
          () => GetProfileUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateProfileUseCase>(
          () => UpdateProfileUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUsecase>(
      () => GetCreateCurrentUserUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrencyRateUseCase>(
          () => GetCurrencyRateUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUPUseCase>(
      () => SignUPUseCase(repository: sl.call()));
  sl.registerLazySingleton<AddNewTransferInfoUseCase>(
      () => AddNewTransferInfoUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetTransferInfoUseCase>(
      () => GetTransferInfoUseCase(repository: sl.call()));

  sl.registerLazySingleton<AddNewCountryRateUseCase>(
          () => AddNewCountryRateUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateCountryRateUseCase >(
          () => UpdateCountryRateUseCase(repository:  sl.call()));
  sl.registerLazySingleton<DeleteCountryRateUseCase >(
          () => DeleteCountryRateUseCase(repository:  sl.call()));
  sl.registerLazySingleton<AddNewExchangeCurrencyUseCase >(
          () => AddNewExchangeCurrencyUseCase(repository:  sl.call()));
  sl.registerLazySingleton<GetExchangeCurrencyUseCase >(
          () => GetExchangeCurrencyUseCase(repository:  sl.call()));
  //repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<AppStateModel>(
          () => AppStateModel(prefs));
  //data source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  //! Core
  sl.registerLazySingleton(() => NetworkInfoImpl());
}
