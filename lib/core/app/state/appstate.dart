import 'package:chegg/core/app/models/app/user_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_preferences_items.dart';

class AppStateModel with ChangeNotifier {
  bool _authenticated = false;
  String? _userToken;
  String? _firebaseToken;
  String? _idToken;
  String? _refreshToken;
  int? _expires;
  String? _email;
  bool _isRememberMeActive = true;
  DateTime? _expiresAt;
  static UserInfo? _userInfo;

  final SharedPreferences prefs;

  // static var _exposedToken;
  // static var _exposedRefreshToken;
  // static DateTime? _exposedExpiresAt;

  /// this method is used in provider to fetch token directly from SharedPreferences
  /// returns null if their is no token
  // Future<String?> get exposedToken async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   if (_exposedToken == null) {
  //     var sUserInfo = _prefs.getString(SharedPreferencesKeys.USER_INFO);
  //     // vat tokenTest=_prefs.get(SharedPreferencesKeys)
  //     if (sUserInfo == null) return null;
  //
  //     var jUserInfo = json.decode(sUserInfo);
  //     if (jUserInfo == null) return null;
  //
  //     var _userInfo = UserInfo.fromJson(jUserInfo);
  //     _exposedToken = _userInfo.token;
  //   }
  //   return _exposedToken;
  // }

  // static Future<String?> get exposedRefreshToken async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   if (_exposedRefreshToken == null) {
  //     var sUserInfo = _prefs.getString(SharedPreferencesKeys.USER_INFO);
  //     // vat tokenTest=_prefs.get(SharedPreferencesKeys)
  //     if (sUserInfo == null) return null;
  //
  //     var jUserInfo = json.decode(sUserInfo);
  //     if (jUserInfo == null) return null;
  //
  //     var _userInfo = UserInfo.fromJson(jUserInfo);
  //     _exposedRefreshToken = _userInfo.refreshToken;
  //   }
  //   return _exposedRefreshToken;
  // }

  bool get isTokenExpired {
    if (_userToken == null) return false;
    if (_expiresAt == null && _userToken != null) return true;
    var remaining = _expiresAt!.difference(DateTime.now());
    if (remaining.inSeconds < 3600) return true; //86390 for testing
    return false;
  }

  // We use a mockmap to enable and disable mock functions/classes.
  // The mock should be injected as a dependency where external dependencies need
  // to be mocked as part of testing.

  bool get authenticated => _authenticated;

  String? get userToken => _userToken;

  String? get firebaseToken => _firebaseToken;

  String? get idToken => _idToken;

  String? get refreshToken => _refreshToken;

  int? get expires => _expires;

  String? get email => _email;

  // UserInfo? get userInfo => _userInfo;

  bool? get isRememberMeActive => _isRememberMeActive;

  DateTime? get expiresAt => _expiresAt;

  AppStateModel(this.prefs) {
    _userToken = prefs.getString(SharedPreferencesKeys.TOKEN);
    _refreshToken = prefs.getString(SharedPreferencesKeys.RefreshTOKEN);
    _expiresAt = DateTime.tryParse(
        prefs.getString(SharedPreferencesKeys.ExpiresAt) ?? "");
    // refresh();
  }

  // void refresh() async {
  //   // Check if the stored token has expired
  //   //initUserInfo();
  //   // if(_userInfo != null){
  //   //   var expiresStr = _userInfo?.tokenExpireInSeconds;
  //   //   if (expiresStr != null) {
  //   //     _expires = DateTime.now().add(Duration(seconds: expiresStr));
  //   //     var remaining = _expires.difference(DateTime.now());
  //   //     if (remaining.inSeconds < 3600) {
  //   //       // var auth = await AuthApiProvider()
  //   //       //     .refreshToken(RequestRefreshModel());
  //   //       if (auth?.result != null ) {
  //   //        // var nUSerInfo = UserInfo.fromAuthenticationModel(auth?.result);
  //   //
  //   //         /// get firebase token
  //   //      //   FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //   //      //   String fcmToken = await _firebaseMessaging.getToken();
  //   //         print('notification token : s $fcmToken s');
  //   //
  //   //         logIn(userInfo:  nUSerInfo,token: nUSerInfo.token,fbToken: fcmToken);
  //   //       } else {
  //   //         prefs.remove('userToken');
  //   //         prefs.remove('expires');
  //   //         prefs.remove(SharedPreferencesKeys.USER_INFO);
  //   //         _authenticated = false;
  //   //         _userToken = null;
  //   //         _expires = null;
  //   //       }
  //   //       notifyListeners();
  //   //       return;
  //   //     }
  //   //   }
  //   //   _userToken = prefs.getString('userToken');
  //   //   if (_userToken != null) {
  //   //     _authenticated = true;
  //   //   }
  //   //   _idToken = prefs.getString('idToken');
  //   //   _refreshToken = prefs.getString('refreshToken');
  //   // //}
  //
  //   notifyListeners();
  // }

  Future<void> setUserInfo(UserInfo? data) async {
    if (data == null) {
      return;
    }

    await prefs.setString(SharedPreferencesKeys.USER_INFO, data.toString());
    _userInfo = data;

    notifyListeners();
  }

  // UserInfo? initUserInfo() {
  //   var userInfoString = prefs.getString(SharedPreferencesKeys.USER_INFO);
  //
  //   if (userInfoString == null) return null;
  //
  //   _userInfo = UserInfo.fromJson(jsonDecode(userInfoString));
  //   return userInfo;
  // }

  void toggleRememberMe() {
    _isRememberMeActive = !_isRememberMeActive;
    notifyListeners();
  }

  Future<void> logIn(
      {UserInfo? userInfo,
      @required token,
      String? fbToken,
      expires,
      refreshToken}) async {
    _userToken = token;
    _firebaseToken = fbToken;
    _expires = expires;
    _refreshToken = refreshToken;
    _expiresAt = DateTime.now().add(Duration(seconds: (_expires ?? 86400)));
    if (token != null) _authenticated = true;
    await setUserInfo(userInfo);
    notifyListeners();
  }

  Future<void> refresh(String token, refreshToken, int expires) async {
    _userToken = token;
    _expires = expires;
    _refreshToken = refreshToken;
    _expiresAt = DateTime.now().add(Duration(seconds: (_expires ?? 86400)));
    prefs.remove(SharedPreferencesKeys.TOKEN);
    prefs.remove(SharedPreferencesKeys.RefreshTOKEN);
    prefs.remove(SharedPreferencesKeys.ExpiresAt);
    await prefs.setString(SharedPreferencesKeys.TOKEN, token);
    await prefs.setString(SharedPreferencesKeys.RefreshTOKEN, refreshToken);
    await prefs.setString(
        SharedPreferencesKeys.ExpiresAt, _expiresAt.toString());
    // prefs.remove(SharedPreferencesKeys.USER_INFO);

    notifyListeners();
  }

  Future<void> profile(String name, String imgurl, String role, int userId,
      String email, String token, String refToken, String expiresAt) async {
    role == "Doctor"
        ? await prefs.setString(SharedPreferencesKeys.User_Name, "Dr." + name)
        : await prefs.setString(SharedPreferencesKeys.User_Name, name);
    await prefs.setString(SharedPreferencesKeys.User_Image, imgurl);
    await prefs.setString(SharedPreferencesKeys.Role_USER, role);
    await prefs.setInt(SharedPreferencesKeys.User_Id, userId);
    await prefs.setString(SharedPreferencesKeys.User_Email, email);
    await prefs.setString(SharedPreferencesKeys.TOKEN, token);
    await prefs.setString(SharedPreferencesKeys.RefreshTOKEN, refToken);
    await prefs.setString(SharedPreferencesKeys.ExpiresAt, expiresAt);
    notifyListeners();
  }

  Future<void> text(
      {UserInfo? userInfo,
      @required token,
      String? fbToken,
      expires,
      refreshToken}) async {
    _userToken = token;
    _firebaseToken = fbToken;
    _expires = expires;
    _refreshToken = refreshToken;
    if (token != null) _authenticated = true;
    await setUserInfo(userInfo);
    notifyListeners();
  }

  void setFirebaseToken(String fbToken) {
    _firebaseToken = fbToken;
    notifyListeners();
  }

  Future<void> logOut() async {
    /* When logging out, the app session is cleared and a new login is needed.
    However, if Auth0 is configured with an IdP, like Google, and the account
    is logged into Google on the device, the user will be directly logged in.
    If closeSessions() is called, the Auth0 session and the IdP session will be 
    logged out. However, the user will be redirected to the IdP login page, which
    may be confusing.
    */
    //AuthClient(authClient:_mocks.getMock('authClient')).closeSessions();
    _authenticated = false;
    _userToken = null;
    _idToken = null;
    _refreshToken = null;
    _expires = null;
    _userInfo = null;
    _expiresAt = null;
    await prefs.clear();
    notifyListeners();
  }
}
