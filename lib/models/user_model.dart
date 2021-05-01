import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/user_role_enum.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserModel({
    required int userId,
    required String fullName,
    required String email,
    required String address,
    required String contact,
    required UserRole role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
