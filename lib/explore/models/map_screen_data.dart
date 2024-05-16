import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

@immutable
class MapScreenData {
  const MapScreenData({
    required this.updatedFogImage,
    required this.markerLocation,
  });
  final Uint8List? updatedFogImage;
  final LatLng markerLocation;
}
