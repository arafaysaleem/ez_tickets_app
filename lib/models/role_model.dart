import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/typedefs.dart';

part 'role_model.freezed.dart';
part 'role_model.g.dart';

@freezed
class RoleModel with _$RoleModel {

  const factory RoleModel({
    required int roleId,
    required String fullName,
    required int age,
    required String pictureUrl,
  }) = _RoleModel;

  factory RoleModel.fromJson(JSON json) =>
      _$RoleModelFromJson(json);
}
