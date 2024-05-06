import 'package:form_field_validator/form_field_validator.dart';

class Validations {
  static final emailValidator = MultiValidator([
    EmailValidator(errorText: 'Enter a valid email address'),
    RequiredValidator(errorText: 'Email address is required'),
  ]);

  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
  ]);

  static final defaultValidator = MultiValidator([
    RequiredValidator(errorText: 'Username is required'),
  ]);
}

class MatchValidator {
  final String errorText;

  MatchValidator({required this.errorText});

  String? validateMatch(String value, String value2) {
    return value == value2 ? null : errorText;
  }
}

class LinkValidations {
  static String? urlValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a URL';
    }

    // Regular expression for URL validation
    final RegExp urlRegExp = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?'
      r'[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}'
      r'(:[0-9]{1,5})?(\/.*)?$',
      caseSensitive: false,
    );

    if (!urlRegExp.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  static bool isURL(String input) {
    RegExp urlRegex = RegExp(
      r'^https?:\/\/(?:www\.)?[\w\-\.\~]+(?:\.[\w\-\~]+)*(?:\/[\w\-\~]+)*(?:\?[\w\-\~]+=[\w\-\~]+)*(?:\&[\w\-\~]+=[\w\-\~]+)*\/?$',
      caseSensitive: false,
    );

    return urlRegex.hasMatch(input);
  }
}
