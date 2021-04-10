import '../utils/constants.dart';

extension StringExt on String {
  bool get isValidEmail => Constants.emailRegex.hasMatch(this);
  bool get isValidFullName => Constants.fullNameRegex.hasMatch(this);
  bool get isValidContact => Constants.contactRegex.hasMatch(this);
}
