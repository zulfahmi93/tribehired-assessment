// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'geo.freezed.dart';
part 'geo.g.dart';

@freezed
class Geo with _$Geo {
  // ------------------------------- CONSTRUCTORS ------------------------------
  @JsonSerializable(checked: true)
  factory Geo({
    @JsonKey(name: 'lat') required String lat,
    @JsonKey(name: 'lng') required String lng,
  }) = _Geo;

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
}
