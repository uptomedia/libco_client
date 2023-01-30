import 'package:chegg/core/routing/route_paths.dart';
import 'package:chegg/features/data/remote/models/transfer_info_model.dart';
import 'package:chegg/features/domain/entities/provider_entity.dart';
import 'package:chegg/features/domain/entities/user_entity.dart';
import 'package:chegg/features/presentation/screen/account/screens/login_screen.dart';
import 'package:chegg/features/presentation/screen/account/screens/setting_screen.dart';
import 'package:chegg/features/presentation/screen/account/screens/signup_screen.dart';
import 'package:chegg/features/presentation/screen/account/screens/welcome_screen.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/order_detail_screen.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/paymeny_method_screen.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/send_money_screen.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/transfer_info_screen.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/add_new_provider_screen.dart';
import 'package:flutter/material.dart';


import '../../features/presentation/screen/home/presentation/screens/detail_provider_screen.dart';
import '../../features/presentation/screen/home/presentation/screens/home_screen.dart';
import '../../features/presentation/screen/navigation/presentation/screens/app_main_screen.dart';


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.LogIn:
        return MaterialPageRoute(builder: (_) => LogInScreen());
      case RoutePaths.SignUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case RoutePaths.NavigationScreen:
        return MaterialPageRoute(
            builder: (_) => AppMainScreen(
                 ));

      case RoutePaths.HomeScreen:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
                // settings.arguments as HomeScreenArgs
                ));
      case RoutePaths.WelcomeScreen:
        return MaterialPageRoute(
            builder: (_) => WelcomeScreen(
                // settings.arguments as HomeScreenArgs
                ));
      case RoutePaths.SendMoneyScreen:
        return MaterialPageRoute(
            builder: (_) => SendMoneyScreen(
                // settings.arguments as HomeScreenArgs
                ));
      case RoutePaths.TarnsferInfoScreen:
        return MaterialPageRoute(
            builder: (_) => TarnsferInfoScreen(providerEntity:
              settings.arguments as ProviderEntity
                ));
      case RoutePaths.SettingScreen:
        return MaterialPageRoute(
            builder: (_) => SettingScreen(
                // settings.arguments as HomeScreenArgs
                ));

      case RoutePaths.PaymentMethodScreen:
        return MaterialPageRoute(
            builder: (_) => PaymentMethodScreen(transferInfo:
                settings.arguments as TransferInfo
                ));
      case RoutePaths.OrderDetailScreen:
        return MaterialPageRoute(
            builder: (_) => OrderDetailScreen(
                // settings.arguments as HomeScreenArgs
                ));
        case RoutePaths.AddNewProviderScreen:
        return MaterialPageRoute(
            builder: (_) => AddNewProviderScreen(
                // settings.arguments as HomeScreenArgs
                ));
        case RoutePaths.DetailsProviderScreen:
        return MaterialPageRoute(
            builder: (_) => DetailsProviderScreen(
              providerEntity: settings.arguments as ProviderEntity
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      // child: Text('No route defined for ${settings.name}'),
                      ),
                ));
    }
  }
}
