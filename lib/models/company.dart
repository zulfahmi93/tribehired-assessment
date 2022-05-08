// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'company.freezed.dart';
part 'company.g.dart';

@freezed
class Company with _$Company {
  // ------------------------------- CONSTRUCTORS ------------------------------
  @JsonSerializable(checked: true)
  factory Company({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'catchPhrase') required String catchPhrase,
    @JsonKey(name: 'bs') required String bs,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}
