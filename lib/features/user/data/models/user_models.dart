// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_models.freezed.dart';
part 'user_models.g.dart';

@freezed
class PublicUser with _$PublicUser {
  const factory PublicUser({
    required String id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    String? username,
    required String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _PublicUser;

  factory PublicUser.fromJson(Map<String, dynamic> json) =>
      _$PublicUserFromJson(json);
}

@freezed
class SearchResponse with _$SearchResponse {
  const factory SearchResponse({
    required List<PublicUser> records,
    required int total,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}
