// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Geo _$$_GeoFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_Geo',
      json,
      ($checkedConvert) {
        final val = _$_Geo(
          lat: $checkedConvert('lat', (v) => v as String),
          lng: $checkedConvert('lng', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_GeoToJson(_$_Geo instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
