// ignore_for_file: unnecessary_this
import '../utils/constants.dart';

extension StringExt on String {
  bool get isValidEmail => Constants.emailRegex.hasMatch(this);
  bool get isValidFullName => Constants.fullNameRegex.hasMatch(this);
  bool get isValidContact => Constants.contactRegex.hasMatch(this);
  String get capitalize =>
      this[0].toUpperCase() + this.substring(1).toLowerCase();
  String get removeUnderScore => this.replaceAll("_", " ");
}
