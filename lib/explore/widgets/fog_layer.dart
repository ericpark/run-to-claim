import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:run_to_claim/constants.dart';
import 'package:run_to_claim/explore/explore.dart';

class FogOfWarLayerWidget extends StatelessWidget {
  const FogOfWarLayerWidget({
    required this.state,
    super.key,
  });

  final MapScreenData state;

  @override
  Widget build(BuildContext context) {
    return OverlayImageLayer(
      overlayImages: [
        OverlayImage(
          bounds: getLatLngBoundsFromCenter(),
          imageProvider: MemoryImage(state.updatedFogImage!),
          opacity: 0.9,
          gaplessPlayback: true,
        ),
      ],
    );
  }
}

LatLngBounds getLatLngBoundsFromCenter({
  LatLng? center,
  double? radius,
}) {
  return LatLngBounds(
    Constants.BROOKLYN_NORTH_WEST,
    Constants.BROOKLYN_SOUTH_EAST,
  );
  /*final lat = center.latitude;
  final lng = center.longitude;
  final latDistance = radius / 110.0;
  final lngDistance = radius / (110.0 * cos(lat * pi / 180.0));
  final minLat = lat - latDistance;
  final maxLat = lat + latDistance;
  final minLng = lng - lngDistance;
  final maxLng = lng + lngDistance;
  return LatLngBounds(LatLng(minLat, minLng), LatLng(maxLat, maxLng));*/
}
