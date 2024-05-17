import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'generated/map_screen_data.freezed.dart';
part 'generated/map_screen_data.g.dart';

@freezed
abstract class MapScreenData with _$MapScreenData {
  factory MapScreenData({
    required LatLng markerLocation,
    @Uint8ListConverter() Uint8List? updatedFogImage,
  }) = _MapScreenData;

  factory MapScreenData.fromJson(Map<String, dynamic> json) =>
      _$MapScreenDataFromJson(json);
}

class Uint8ListConverter implements JsonConverter<Uint8List?, dynamic> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(dynamic imageData) => null;

  @override
  String? toJson(Uint8List? imageData) => null;
}
