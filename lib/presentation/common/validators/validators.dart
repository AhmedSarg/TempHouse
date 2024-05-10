import 'package:easy_localization/easy_localization.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';

class AppValidators {
  AppValidators._();

  static String? validateEmail(String? val) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (val == null) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.trim().isEmpty) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (emailRegex.hasMatch(val) == false) {
      return AppStrings.validationsValidEmail.tr();
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])');
    if (val == null) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.isEmpty) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.length < 8 || !passwordRegex.hasMatch(val)) {
      return AppStrings.validationsPasswordSpecifications.tr();
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val != password) {
      return AppStrings.validationsEnterTheSamePassword.tr();
    } else {
      return null;
    }
  }

  static String? validateUsername(String? val) {
    RegExp usernameRegex = RegExp(r'^[a-zA-Z,.-]+$');
    if (val == null) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.isEmpty) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (!usernameRegex.hasMatch(val)) {
      return AppStrings.validationsUsername.tr();
    } else {
      return null;
    }
  }

// static String? validateNationalID(String? val) {
//   if (val == null) {
//     return AppStrings.validationsFieldRequired.tr();
//   } else if (int.tryParse(val.trim()) == null) {
//     return AppStrings.validationsNumbersOnly.tr();
//   } else if (val.trim().length != 14) {
//     return AppStrings.validationsNumbersMustEqual14Digit.tr();
//   } else {
//     return null;
//   }
// }
//
  static String? validatePhoneNumber(String? val) {
    if (val == null) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (int.tryParse(val.trim()) == null) {
      return AppStrings.validationsNumbersOnly.tr();
    } else if (val.trim().length != 11) {
      return AppStrings.validationsNumbersMustEqual11Digit.tr();
    } else {
      return null;
    }
  }

  static String? validateGender(String? val) {
    if (val == null) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.trim().isEmpty) {
      return AppStrings.validationsFieldRequired.tr();
    } else {
      return null;
    }
  }

  static String? validateJob(String? val) {
    if (val == null) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.trim().isEmpty) {
      return AppStrings.validationsFieldRequired.tr();
    } else {
      return null;
    }
  }

  static String? validateSalary(String? val) {
    if (val == null) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.trim().isEmpty) {
      return AppStrings.validationsFieldRequired.tr();
    } else {
      return null;
    }
  }

  static String? validatePrice(String? val) {
    if (val == null) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.trim().isEmpty) {
      return AppStrings.validationsFieldRequired.tr();
    } else {
      return null;
    }
  }

  static String? validateAge(String? val) {
    if (val == null) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.trim().isEmpty) {
      return AppStrings.validationsFieldRequired.tr();
    } else {
      return null;
    }
  }

  static String? validateMartialStatus(String? val) {
    if (val == null) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.trim().isEmpty) {
      return AppStrings.validationsFieldRequired.tr();
    } else {
      return null;
    }
  }

  static String? validateLogin(String? val) {
    if (val == null) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.trim().isEmpty) {
      return AppStrings.validationsFieldRequired.tr();
    } else {
      return null;
    }
  }


  static String? validateText(String? val) {
    if (val == null) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.isEmpty) {
      return AppStrings.validationsFieldRequired.tr();
    } else if (val.length < 4 ) {
      return AppStrings.validationsTitle.tr();
    } else {
      return null;
    }
  }

//
// static String? validateUniversity(String? val) {
//   if (val == null) {
//     return AppStrings.validationsFieldRequired.tr();
//   } else if (val.trim().isEmpty) {
//     return AppStrings.validationsFieldRequired.tr();
//   } else {
//     return null;
//   }
// }
//
// static String? validateCollege(String? val) {
//   if (val == null) {
//     return AppStrings.validationsFieldRequired.tr();
//   } else if (val.trim().isEmpty) {
//     return AppStrings.validationsFieldRequired.tr();
//   } else {
//     return null;
//   }
// }
//
// static String? validateAcademicYear(String? val) {
//   if (val == null) {
//     return AppStrings.validationsFieldRequired.tr();
//   } else if (val.trim().isEmpty) {
//     return AppStrings.validationsFieldRequired.tr();
//   } else {
//     return null;
//   }
// }
}
