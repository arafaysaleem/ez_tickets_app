// ignore_for_file: unnecessary_this

extension IntExt on int {
  Duration get milliseconds => Duration(milliseconds: this);
  Duration get microseconds => Duration(microseconds: this);
  Duration get seconds => Duration(seconds: this);
}
