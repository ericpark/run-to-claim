import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'generated/explore_state.freezed.dart';
part 'generated/explore_state.g.dart';

enum MapStatus { initial, loading, transitioning, success, failure }

extension MapStatusX on MapStatus {
  bool get isInitial => this == MapStatus.initial;
  bool get isLoading => this == MapStatus.loading;
  bool get isTransitioning => this == MapStatus.transitioning;
  bool get isSuccess => this == MapStatus.success;
  bool get isFailure => this == MapStatus.failure;
}

@freezed
abstract class ExploreState with _$ExploreState {
  factory ExploreState({
    @Default(MapStatus.initial) MapStatus mapStatus,
    @Default(LatLng(40.7128, -74.0060)) LatLng currentPosition,
    @Default({}) Set<LatLng> pastPositions,
    @Default(AlignOnUpdate.once) AlignOnUpdate alignPositionOnUpdate,
    @_Uint8ListConverter() Uint8List? fogImageData,
    @_ImageConverterPlaceholder() @Default(null) ui.Image? fogImage,
  }) = _ExploreState;
  factory ExploreState.fromJson(Map<String, dynamic> json) =>
      _$ExploreStateFromJson(json);
}

class _Uint8ListConverter implements JsonConverter<Uint8List?, dynamic> {
  const _Uint8ListConverter();

  @override
  Uint8List? fromJson(dynamic json) {
    if (json is List<int>) {
      return Uint8List.fromList(json);
    }
    return Uint8List.fromList([]);
  }

  @override
  dynamic toJson(Uint8List? image) {
    final output = image?.toList() ?? [];
    return output;
  }
}

/// The will not be saved because converting the data to json is async.
/// Image will be recreated on on ExploreCubit's [fromJson]
class _ImageConverterPlaceholder implements JsonConverter<ui.Image?, dynamic> {
  const _ImageConverterPlaceholder();

  @override
  ui.Image? fromJson(dynamic json) {
    return null;
  }

  @override
  dynamic toJson(ui.Image? image) {
    return null;
  }
}
