import 'package:template/core/constants/constants.dart';

/// Validates a password based on certain criteria.
///
/// This function checks if the given password meets the following requirements:
/// - It is not null or empty.
/// - It is at least 8 characters long.
/// - It contains at least one number.
/// - It contains at least one letter.
/// - It contains at least one capital letter.
/// - It contains at least one number and letter.
///
/// @param val The password to be validated.
/// @return A [String] message indicating the validation result. If the password is valid, it returns `null`.
String? validatePassword(String? val) {
  if (val == null || val.isEmpty) {
    return 'لا يمكن أن تكون كلمة المرور فارغة';
  }

  if (val.length < 8) {
    return 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
  }

  if (!AppRegex.numRegEx.hasMatch(val.trim())) {
    return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';
  }

  if (!AppRegex.letterRegEx.hasMatch(val.trim())) {
    return 'يجب أن تحتوي كلمة المرور على حرف واحد على الأقل';
  }

  if (!AppRegex.uppercaseRegEx.hasMatch(val.trim())) {
    return 'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل';
  }

  // if (!AppRegex.passwordRegEx.hasMatch(val)) {
  //   return 'يجب أن تحتوي كلمة المرور على رقم واحد وحرف واحد على الأقل';
  // }

  return null; // Return null if validation passes
}

String? validateEmail(String? val) =>
    val != null && AppRegex.emailRegEx.hasMatch(val.trim())
        ? null
        : 'أدخل بريدًا إلكترونيًا صالحًا';

String? validateUserName(String? val) =>
    val != null && AppRegex.userNameRegEx.hasMatch(val.trim())
        ? null
        : 'اسم المستخدم غير صالح';

String? validatePhoneNumber(String? val) =>
// AppRegex.phoneNumberRegEx.hasMatch(val.trim())
    val != null && val.trim().isNotEmpty ? null : 'رقم الهاتف غير صالح';

//  validate text aria
String? validateTextAria(String? val) {
  if (val == null || val.isEmpty) {
    return 'لا يمكن أن تكون الرسالة فارغة';
  }
  if ((val.trim()).length < 50) {
    return 'يجب أن تكون الرسالة 50 أحرف على الأقل';
  }
  return null;
}

String? validateUserNameEnglish(String? val) =>
    val != null && AppRegex.userNameRegEx.hasMatch(val.trim())
        ? null
        : 'Username is invalid';

String? validateEmailEnglish(String? val) =>
    val != null && AppRegex.emailRegEx.hasMatch(val.trim())
        ? null
        : 'Enter a valid email';

String? validatePasswordEnglish(String? val) {
  if (val == null || val.isEmpty) {
    return 'Password cannot be empty';
  }

  if (val.length < 8) {
    return 'Password must be at least 8 characters long';
  }

  if (!AppRegex.numRegEx.hasMatch(val.trim())) {
    return 'Password must contain at least one number';
  }

  if (!AppRegex.letterRegEx.hasMatch(val.trim())) {
    return 'Password must contain at least one character';
  }

  if (!AppRegex.uppercaseRegEx.hasMatch(val.trim())) {
    return 'Password must contain at least one uppercase letter';
  }

  // if (!AppRegex.passwordRegEx.hasMatch(val)) {
  //   return 'يجب أن تحتوي كلمة المرور على رقم واحد وحرف واحد على الأقل';
  // }

  return null; // Return null if validation passes
}
