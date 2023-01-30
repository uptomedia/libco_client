import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^.{6,26}$',
  );
  static final RegExp _dateRegExp =
      RegExp('^(3[01]|[12][0-9]|0[1-9])-(1[0-2]|0[1-9])-[0-9]{4}');
  static final RegExp _nameRegExp = RegExp(r'[0-9]^(?!\s*$).+');

  // static final RegExp _phoneNumberRegExp = RegExp(r'^(?!0+$)(\+\d{1,3}[- ]?)?(?!0+$)\d{9,15}$');
  static final RegExp _phoneNumberRegExp = RegExp(r'^(0|00)[1-9]\d{8,14}$');

  // static final RegExp _phoneNumberRegExp = RegExp(r'^(?:00)(\+\d{1,3}[- ]?)|(?:01)(\+\d{0,1}[- ]?)?(?!0+$)\d{9,15}$');
  static final RegExp _nameRegExpText =
      RegExp(r'^[a-zA-Z \u00E4\u00F6\u00FC\u00C4\u00D6\u00DC\u00df]*$');

  static final RegExp _fullNameRegExp = RegExp(r'^(?!\s*$).+ (?!\s*$).+');

  static isNotEmptyString(String string) {
    return string.trim() != "";
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static hasCharacters(String text) {
    text = text.replaceAll(" ", "");
    return text.length > 0;
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isChecked(bool value) {
    return value;
  }

  static isValidName(String name) {
    return _nameRegExp.hasMatch(name);
  }

  static isValidFirstName(String name) {
    return !_nameRegExpText.hasMatch(name);
  }

  static isValidFullName(String name) {
    return _fullNameRegExp.hasMatch(name);
  }

  static isValidConfirmPassword(String password, String confirmPassword) {
    return (password == confirmPassword);
  }

  static isValidPhoneNumber(String phone) {
    // return phone != null &&
    //     phone.isNotEmpty &&
    //     (phone.startsWith('01') || phone.startsWith('+')) &&
    //     phone.length >= 11 && phone.length < 12;

    return _phoneNumberRegExp.hasMatch(phone);
  }

  static isValidaddress(String newFullCountry, String newCity, String newStreet,
      String newStreetNumber, String newZipCode, String value) {
    if (newFullCountry != "" ||
        newCity != "" ||
        newStreet != "" ||
        newStreetNumber != "" ||
        newZipCode != "" ||
        value == "") {
      return true;
    } else {
      return false;
    }
  }

  static isvalidBirthDate(String date) {
    if (date == "") return false;
    if (date.length < 10) return false;
    try {
      DateTime dateTime = DateFormat("dd-MM-yyyy", 'en').parseStrict(date);

      return _dateRegExp.hasMatch(date) &&
          date.length == 10 &&
          DateTime.now().isAfter(dateTime);
    } catch (e) {
      Fluttertoast.showToast(msg: "not valid date of birth");
    }
  }

  static isvalidDate(String date) {
    String datePattern = "dd-mm-yyyy";

    return date != null &&
        date.isNotEmpty &&
        (DateFormat(datePattern, 'en').parse(date) != null);
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static isValidStreetNameNumber(String name) {
    return true;
    bool valid = false;
    var result = name.trim();
    var r = name.trim().split(" ");

    if (r.length <= 0 || (int.tryParse(r.last) == null)) {
      valid = false;
    }
    // else
    //   valid = true;
    else if (result != null && r.length >= 2) {
      for (var i = 0; i < result.length; i++) {
        if (result[i].contains(new RegExp(r'[0-9٠-٩]'))) valid = true;
      }
      if (result.isNotEmpty && valid) {
        valid = false;
        for (var i = 0; i < result.length; i++) {
          if (result[i].contains(new RegExp(r'[a-zA-Zأ-ي]'))) valid = true;
        }
      } else {
        valid = false;
      }
    }
    return valid;
  }
}
