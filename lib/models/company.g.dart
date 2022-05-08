// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Company _$$_CompanyFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_Company',
      json,
      ($checkedConvert) {
        final val = _$_Company(
          name: $checkedConvert('name', (v) => v as String),
          catchPhrase: $checkedConvert('catchPhrase', (v) => v as String),
          bs: $checkedConvert('bs', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_CompanyToJson(_$_Company instance) =>
    <String, dynamic>{
      'name': instance.name,
      'catchPhrase': instance.catchPhrase,
      'bs': instance.bs,
    };
