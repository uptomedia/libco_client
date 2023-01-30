import 'package:chegg/core/features/feature/data/models/params/params_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared_preferences_items.dart';

abstract class LocalDataSource {
  Future<dynamic> get(ParamsModel model) async {
    try {
      SharedPreferences _spf;
      _spf = await SharedPreferences.getInstance();

      return {
        "registered":
            _spf.getBool(SharedPreferencesKeys.WIZARD_REGISTER) ?? false,
      };
    } catch (e) {
      throw e;
    }
  }
}
