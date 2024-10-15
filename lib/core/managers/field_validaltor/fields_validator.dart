class FieldsValidator {
  static String? isNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field must not be empty';
    }
    return null;
  }

  static String? isValidEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    return null;
    // const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    // final regex = RegExp(emailPattern);
    // if (!regex.hasMatch(value)) {
    //   return 'Please enter a valid email address format (e.g., user@example.com)';
    // }
    // if (!value.contains('@')) {
    //   return 'Email address must contain an "@" symbol';
    // }
    // return null;
  }

  static String? isValidPassword(String? value, {int minLength = 8}) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }
    return null;
  }

  static String? isValidPhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    const phonePattern = r'^\+?[0-9]{7,15}$';
    final regex = RegExp(phonePattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid phone number with 7 to 15 digits';
    }
    return null;
  }

  static String? isValidURL(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required';
    }
    const urlPattern = r'^(https?:\/\/)?([\w\d\-]+\.)+[\w]{2,}(\/.+)?$';
    final regex = RegExp(urlPattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  static String? isValidUsername(String? value,
      {int minLength = 3, int maxLength = 20}) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }

    if (value.length < minLength) {
      return 'Username must be at least $minLength characters long';
    }
    if (value.length > maxLength) {
      return 'Username must be at most $maxLength characters long';
    }

    const usernamePattern = r'^[a-zA-Z0-9_]+$';
    final regex = RegExp(usernamePattern);
    if (!regex.hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }

    return null;
  }
}
