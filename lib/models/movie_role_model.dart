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

  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory MovieRoleModel({
    required RoleModel role,
    required RoleType roleType,
  }) = _MovieRoleModel;

  factory MovieRoleModel.fromJson(Map<String, dynamic> json) =>
      _$MovieRoleModelFromJson(json);

  factory MovieRoleModel.fromJsonCustom(Map<String, dynamic> json) {
    final Map<String,dynamic> movieRole = {
      "role": json,
      "role_type" : json["role_type"],
    };
    return MovieRoleModel.fromJson(movieRole);
  }

  Map<String, dynamic> toCustomJson() {
    return {
      "role_id": this.role.roleId,
      "role_type": this.roleType.toJson,
    };
  }
}
