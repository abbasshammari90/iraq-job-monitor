class ValidationService {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^[+]?[(]?[0-9]{1,4}[)]?[-\s.]?[(]?[0-9]{1,4}[)]?[-\s.]?[0-9]{1,9}\$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number format';
    }
    return null;
  }

  static String? validateKeyword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Keyword is required';
    }
    if (value.length < 2) {
      return 'Keyword must be at least 2 characters';
    }
    if (value.length > 50) {
      return 'Keyword must not exceed 50 characters';
    }
    return null;
  }

  static String? validateText(String? value, {int minLength = 1, int maxLength = 255}) {
    if (value == null || value.isEmpty) {
      return 'Text is required';
    }
    if (value.length < minLength) {
      return 'Text must be at least $minLength characters';
    }
    if (value.length > maxLength) {
      return 'Text must not exceed $maxLength characters';
    }
    return null;
  }
}
