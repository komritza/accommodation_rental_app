// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => _AuthUser(
  id: json['id'] as String,
  tenantId: json['tenantId'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
);

Map<String, dynamic> _$AuthUserToJson(_AuthUser instance) => <String, dynamic>{
  'id': instance.id,
  'tenantId': instance.tenantId,
  'role': _$UserRoleEnumMap[instance.role]!,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};

const _$UserRoleEnumMap = {UserRole.client: 'client', UserRole.host: 'host'};

_AuthSession _$AuthSessionFromJson(Map<String, dynamic> json) => _AuthSession(
  accessToken: json['accessToken'] as String,
  user: AuthUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthSessionToJson(_AuthSession instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'user': instance.user.toJson(),
    };
