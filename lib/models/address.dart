// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'geo.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  // ------------------------------- CONSTRUCTORS ------------------------------
  @JsonSerializable(checked: true)
  factory Address({
    @JsonKey(name: 'street') required String street,
    @JsonKey(name: 'suite') required String suite,
    @JsonKey(name: 'city') required String city,
    @JsonKey(name: 'zipcode') required String zipcode,
    @JsonKey(name: 'geo') required Geo geo,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
