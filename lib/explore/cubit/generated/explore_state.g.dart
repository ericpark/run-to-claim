// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of '../explore_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExploreStateImpl _$$ExploreStateImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ExploreStateImpl',
      json,
      ($checkedConvert) {
        final val = _$ExploreStateImpl(
          mapStatus: $checkedConvert(
              'map_status',
              (v) =>
                  $enumDecodeNullable(_$MapStatusEnumMap, v) ??
                  MapStatus.initial),
          currentPosition: $checkedConvert(
              'current_position',
              (v) => v == null
                  ? const LatLng(40.7128, -74.0060)
                  : LatLng.fromJson(v as Map<String, dynamic>)),
          pastPositions: $checkedConvert(
              'past_positions',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => LatLng.fromJson(e as Map<String, dynamic>))
                      .toSet() ??
                  const {}),
          alignPositionOnUpdate: $checkedConvert(
              'align_position_on_update',
              (v) =>
                  $enumDecodeNullable(_$AlignOnUpdateEnumMap, v) ??
                  AlignOnUpdate.once),
          fogImageData: $checkedConvert(
              'fog_image_data', (v) => const _Uint8ListConverter().fromJson(v)),
          fogImage: $checkedConvert(
              'fog_image',
              (v) => v == null
                  ? null
                  : const _ImageConverterPlaceholder().fromJson(v)),
        );
        return val;
      },
      fieldKeyMap: const {
        'mapStatus': 'map_status',
        'currentPosition': 'current_position',
        'pastPositions': 'past_positions',
        'alignPositionOnUpdate': 'align_position_on_update',
        'fogImageData': 'fog_image_data',
        'fogImage': 'fog_image'
      },
    );

Map<String, dynamic> _$$ExploreStateImplToJson(_$ExploreStateImpl instance) =>
    <String, dynamic>{
      'map_status': _$MapStatusEnumMap[instance.mapStatus]!,
      'current_position': instance.currentPosition.toJson(),
      'past_positions': instance.pastPositions.map((e) => e.toJson()).toList(),
      'align_position_on_update':
          _$AlignOnUpdateEnumMap[instance.alignPositionOnUpdate]!,
      'fog_image_data':
          const _Uint8ListConverter().toJson(instance.fogImageData),
      'fog_image': const _ImageConverterPlaceholder().toJson(instance.fogImage),
    };

const _$MapStatusEnumMap = {
  MapStatus.initial: 'initial',
  MapStatus.loading: 'loading',
  MapStatus.transitioning: 'transitioning',
  MapStatus.success: 'success',
  MapStatus.failure: 'failure',
};

const _$AlignOnUpdateEnumMap = {
  AlignOnUpdate.never: 'never',
  AlignOnUpdate.once: 'once',
  AlignOnUpdate.always: 'always',
};
