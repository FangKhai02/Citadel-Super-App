import 'package:citadel_super_app/main.dart';
import 'package:flutter/material.dart';

BuildContext? getAppContext() {
  final context = navigatorKey.currentContext;
  return context;
}

BuildContext? get appContext {
  return navigatorKey.currentContext;
}

bool needGuardian(DateTime dob) {
  final DateTime today = DateTime.now();
  final int age = today.year - dob.year;

  if (age == 18) {
    return (today.month > dob.month ||
        (today.month == dob.month && today.day > dob.day));
  } else {
    return age < 18;
  }
}

String? validatePercentage(String percentage) {
  // Updated regex to allow whole numbers or decimal numbers
  final regex = RegExp(r'^\d+(\.\d+)?$');
  if (regex.hasMatch(percentage)) {
    return null;
  } else {
    return "Percentage must contain numbers only.";
  }
}

String? validateEmail(String email) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(email)) {
    return "Invalid email address";
  }
  return null;
}

String? validatePassword(String password) {
  // Minimum length of 8 characters
  if (password.length < 8) {
    return "Password must be at least 8 characters long.";
  }

  // At least one uppercase letter
  if (!RegExp(r'[A-Z]').hasMatch(password)) {
    return "Password must contain at least one uppercase letter.";
  }

  // At least one lowercase letter
  if (!RegExp(r'[a-z]').hasMatch(password)) {
    return "Password must contain at least one lowercase letter.";
  }

  // At least one digit
  if (!RegExp(r'[0-9]').hasMatch(password)) {
    return "Password must contain at least one digit.";
  }

  // At least one special character
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
    return "Password must contain at least one special character.";
  }

  return null;
}
