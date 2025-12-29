// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublicUserImpl _$$PublicUserImplFromJson(Map<String, dynamic> json) =>
    _$PublicUserImpl(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      username: json['username'] as String?,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$$PublicUserImplToJson(_$PublicUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'username': instance.username,
      'email': instance.email,
      'avatar_url': instance.avatarUrl,
    };

_$SearchResponseImpl _$$SearchResponseImplFromJson(Map<String, dynamic> json) =>
    _$SearchResponseImpl(
      records: (json['records'] as List<dynamic>)
          .map((e) => PublicUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$SearchResponseImplToJson(
        _$SearchResponseImpl instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
    };
