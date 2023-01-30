import 'package:chegg/core/configurations/app_configuration.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateless_widget.dart';
import 'package:chegg/core/routing/route_paths.dart';
import 'package:chegg/core/routing/router.dart';
import 'package:chegg/features/data/remote/models/transfer_info_model.dart';
import 'package:chegg/features/presentation/bloc/currency_rate/currency_rate_cubit.dart';
import 'package:chegg/features/presentation/bloc/exchange_currency/exchange_currency_cubit.dart';
import 'package:chegg/features/presentation/screen/account/screens/provider/user_state_provider.dart';
import 'package:chegg/features/presentation/screen/account/screens/welcome_screen.dart';
import 'package:chegg/features/presentation/screen/navigation/presentation/screens/app_main_screen.dart';
import 'package:chegg/features/presentation/screen/navigation/presentation/screens/splash_screen.dart';
  import 'package:chegg/generated/l10n.dart';
import 'package:chegg/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants.dart';
import 'features/presentation/bloc/money_provider/money_provider_cubit.dart';
import 'features/presentation/bloc/tranfer_info/transfer_info_cubit.dart';
import 'injection_container.dart' as di;

import 'core/app/state/appstate.dart';
import 'core/configurations/styles.dart';
import 'core/shared_preferences_items.dart';

  import 'features/presentation/bloc/auth/auth_cubit.dart';
import 'features/presentation/bloc/user/user_cubit.dart';
 import 'l10n/L10n.dart';
import 'l10n/locale_provider.dart';
import 'l10n/selected_provider.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // configureDependencies();

// Set landscape orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Styles.colorPrimary, //or set color with: Color(0xFF0000FF)
  ));
  SharedPreferences prefs = await SharedPreferences.getInstance();
   await di.init(prefs);

  runApp(Phoenix(
    child: MyApp(prefs),
  ));
}

class MyApp extends AppStatelessWidget {
  final preferences;

  MyApp(this.preferences);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppStateModel(preferences),
        ),
        ChangeNotifierProvider(
          create: (context) => UserStateProvider(),
        ),
        BlocProvider<AuthCubit>(create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_) =>  di.sl<UserCubit>()),
        BlocProvider<MoneyProviderCubit>(create: (_) =>  di.sl<MoneyProviderCubit>()),
        BlocProvider<CurrencyRateCubit>(create: (_) =>  di.sl<CurrencyRateCubit>()),
        BlocProvider<TransferInfoCubit>(create: (_) =>  di.sl<TransferInfoCubit>()),
        BlocProvider<ExchangeCurrencyCubit>(create: (_) =>  di.sl<ExchangeCurrencyCubit>()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => SelectedProvider()),

      ],
      child: App(AppStateModel(preferences), preferences),
    );
  }
}

class App extends AppStatelessWidget {
  Locale _locale = new Locale('en', '');

  App(this.appStateModel, this.pref);

  AppStateModel appStateModel;
  SharedPreferences pref;
  var x;

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
       ChangeNotifierProvider(create: (_) => LocaleProvider()),
    ],
    child:

      ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          x = sl<AppStateModel>()
                  .prefs
                  .containsKey(SharedPreferencesKeys.LanguageCode)
              ? sl<AppStateModel>()
                  .prefs
                  .getString(SharedPreferencesKeys.LanguageCode)
              : 'en';
          // provider.setLocale(Locale(x));

          return ScreenUtilInit(
            designSize: Size(360, 800),
            builder: (BuildContext context, Widget? widget) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  S.delegate
                ],
                supportedLocales: L10n.all,

                locale: sl<AppStateModel>()
                        .prefs
                        .containsKey(SharedPreferencesKeys.LanguageCode)
                    ? Locale(x.toString(), '')
                    : provider.locale,
                title: AppConfigurations.ApplicationName,

                routes: {
                  "/": (context) {
                    return BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, authState) {
                      if (authState is Authenticated) {
                        Constants.UID=authState.uid;
                        // di.sl<UserCubit>().getProfile(authState.uid);
                        return AppMainScreen( );
                      }
                      if (authState is UnAuthenticated) {
                        return WelcomeScreen();
                      }

                      return CircularProgressIndicator();
                    });
                  }
                },
                initialRoute:'/',

                // BlocProvider.of<AuthCubit>(context).state is Authenticated?
                // RoutePaths.NavigationScreen:RoutePaths.WelcomeScreen,
                // theme: appTheme,
                onGenerateRoute: AppRouter.generateRoute,
              );
            },
          );
        })
      );
  }
}
