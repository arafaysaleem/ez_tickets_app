import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/role_type_enum.dart';

part 'movie_role_model.freezed.dart';
part 'movie_role_model.g.dart';

@freezed
abstract class MovieRoleModel with _$MovieRoleModel {

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MovieRoleModel({
    required int roleId,
    required RoleType roleType
  }) = _MovieRoleModel;

  factory MovieRoleModel.fromJson(Map<String, dynamic> json) =>
      _$MovieRoleModelFromJson(json);
}

