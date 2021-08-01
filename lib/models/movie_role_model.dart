import 'package:freezed_annotation/freezed_annotation.dart';

//Enums
import '../enums/role_type_enum.dart';

//Models
import 'role_model.dart';

part 'movie_role_model.freezed.dart';
part 'movie_role_model.g.dart';

@freezed
class MovieRoleModel with _$MovieRoleModel {
  const MovieRoleModel._();

  @JsonSerializable()
  const factory MovieRoleModel({
    required int movieId,
    required RoleModel role,
    required RoleType roleType,
  }) = _MovieRoleModel;

  factory MovieRoleModel.fromJson(Map<String, dynamic> json) =>
      _$MovieRoleModelFromJson(json);

  Map<String, dynamic> toCustomJson() {
    return <String, dynamic>{
      'role_id': role.roleId,
      'role_type': roleType.toJson,
    };
  }
}
