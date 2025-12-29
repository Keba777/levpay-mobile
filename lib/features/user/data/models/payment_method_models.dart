// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method_models.freezed.dart';
part 'payment_method_models.g.dart';

@freezed
class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required String id,
    required String type,
    @JsonKey(name: 'is_default') required bool isDefault,
    required bool verified,
    @JsonKey(name: 'last_four_digits') String? lastFourDigits,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}
