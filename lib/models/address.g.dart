// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Address _$$_AddressFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_Address',
      json,
      ($checkedConvert) {
        final val = _$_Address(
          street: $checkedConvert('street', (v) => v as String),
          suite: $checkedConvert('suite', (v) => v as String),
          city: $checkedConvert('city', (v) => v as String),
          zipcode: $checkedConvert('zipcode', (v) => v as String),
          geo: $checkedConvert(
              'geo', (v) => Geo.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_AddressToJson(_$_Address instance) =>
    <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'geo': instance.geo,
    };
