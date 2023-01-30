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
int _index=-1;
  ProviderEntity get providerEntity => _providerEntity;
  int get index => _index;
  UserEntity get userEntity => _userEntity;
  bool get isSelected => _isSelected;
  late UserEntity _userEntity;
  void setUserEntity(UserEntity selected) {
    _userEntity = selected;
     // Constants.countrysList=selected.countryrate.single;
    notifyListeners();
  }
  void setProvider(ProviderEntity selected,int indexVal) {
    _isSelected=true;
    _providerEntity = selected;
    _index=indexVal;

    Constants.countrysList=[];

    // Constants.countrysList=selected.countryrate.single;
    notifyListeners();
  }

  void clearProvider() {
    _isSelected=false;
    Constants.countrysList=[];
    _index=-1;
    _providerEntity = ProviderEntity(
        name: "",
        imagePath: "",
        providerId: "",
        countryrate:  Stream.empty()
    );
    notifyListeners();
  }
}
