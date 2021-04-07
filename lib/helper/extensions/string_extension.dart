import '../utils/constants.dart';

extension StringExt on String {
  bool get isValidEmail => Constants.emailRegex.hasMatch(this);
}
