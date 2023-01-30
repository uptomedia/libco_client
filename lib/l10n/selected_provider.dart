import 'package:flutter/material.dart';

import '../core/constants.dart';
import '../features/domain/entities/provider_entity.dart';
import '../features/domain/entities/user_entity.dart';
import 'L10n.dart';

class SelectedProvider extends ChangeNotifier {
  ProviderEntity _providerEntity = ProviderEntity(
    name: "",
    imagePath: "",
    providerId: "",
    countryrate: Stream.empty()
  );
bool _isSelected=false;
  ProviderEntity get providerEntity => _providerEntity;
  UserEntity get userEntity => _userEntity;
  bool get isSelected => _isSelected;
  late UserEntity _userEntity;
  void setUserEntity(UserEntity selected) {
    _userEntity = selected;

    // Constants.countrysList=selected.countryrate.single;
    notifyListeners();
  }
  void setProvider(ProviderEntity selected) {
    _isSelected=true;
    _providerEntity = selected;
    Constants.countrysList=[];

    // Constants.countrysList=selected.countryrate.single;
    notifyListeners();
  }

  void clearProvider() {
    _isSelected=false;
    Constants.countrysList=[];

    _providerEntity = ProviderEntity(
        name: "",
        imagePath: "",
        providerId: "",
        countryrate:  Stream.empty()
    );
    notifyListeners();
  }
}
