class Validators {
  /// Validates that the value is a valid email address.
  static final RegExp _goodEmailFormat = RegExp(
    r"^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$",
    caseSensitive: false,
  );

  /// Validates that the value is a valid name.
  static final RegExp _goodNameFormat = RegExp(r'^[a-zA-Z]+$');

  /// Checks if name is valid.
  /// A valid name is non-empty and contains only alphabetic characters.
  /// Returns an error message if the name is invalid.
  static String? checkName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Enter a name';
    }
    if (!_goodNameFormat.hasMatch(name)) {
      return 'Name must contain only alphabetic characters.';
    }

    return null;
  }

  /// Checks if email is valid. If it is, returns `null`, otherwise returns an error message.
  static String? checkEmail(String? email) {
    /// If email is empty.
    if (email == null || email.isEmpty) {
      return 'Name is required';
    }

    /// If email is not valid.
    if (!_goodEmailFormat.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Checks if password has valid format. If not, returns an error message.
  static String? checkPassword(String? password) {
    /// If email is empty.
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    /// If email is not valid.
    if (!_PasswordRegExp.lenghtRule.hasMatch(password)) {
      return _PasswordRegExp.lenghtRuleErrorMessage;
    }

    if (!_PasswordRegExp.upperCaseRule.hasMatch(password)) {
      return _PasswordRegExp.upperCaseRuleErrorMessage;
    }

    if (!_PasswordRegExp.lowerCaseRule.hasMatch(password)) {
      return _PasswordRegExp.lowerCaseRuleErrorMessage;
    }

    if (!_PasswordRegExp.digitRule.hasMatch(password)) {
      return _PasswordRegExp.digitRuleErrorMessage;
    }

    if (!_PasswordRegExp.specialCharacterRule.hasMatch(password)) {
      return _PasswordRegExp.specialCharacterRuleErrorMessage;
    }

    return null;
  }
}

class _PasswordRegExp {
  static RegExp upperCaseRule = RegExp(r'(?=(?:.*[A-Z]){1,})');
  static String upperCaseRuleErrorMessage =
      'Password must contain at least one upper case letter';

  static RegExp lowerCaseRule = RegExp(r'(?=(?:.*[a-z]){1,})');
  static String lowerCaseRuleErrorMessage =
      'Password must contain at least one lower case letter';

  static RegExp digitRule = RegExp(r'(?=(?:.*\d){1,})');
  static String digitRuleErrorMessage =
      'Password must contain at least one digit (0-9)';

  static RegExp specialCharacterRule =
      RegExp(r'(?=(?:.*[!@#$%^&*()\-_=+{};:,<.>]){1,})');
  static String specialCharacterRuleErrorMessage =
      r'Password must contain at least one of these special characters: !@#$%^&*()\-_=+{};:,<.>';

  static RegExp lenghtRule =
      RegExp(r'([A-Za-z0-9!@#$%^&*()\-_=+{};:,<.>]{8,46})');
  static String lenghtRuleErrorMessage =
      r'Password must have atleast 8 characters and no more than 46 characters.';
}
