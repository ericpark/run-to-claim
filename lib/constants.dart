// ignore_for_file: constant_identifier_names

import 'package:latlong2/latlong.dart';

class Constants {
  static const String MAP_TILE_URL =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  static const String FOG_IMAGE_FILE = 'assets/fog.png';

  static const LatLng INITIAL_LOCATION = LatLng(40.7128, -74.0060);

  static const LatLng BROOKLYN_NORTH_WEST = LatLng(40.7397, -74.0412);
  static const LatLng BROOKLYN_SOUTH_EAST = LatLng(40.5707, -73.8331);

  static const int IMG_WIDTH = 512;
  static const int IMG_HEIGHT = 512;
  static const int IMG_RESOLUTION = IMG_WIDTH * IMG_HEIGHT;

  static const double MIN_ZOOM = 11;
  static const double MAX_ZOOM = 18;
  static const double DEFAULT_ZOOM = 15;

  static const double EXPLORATION_RADIUS_IN_METERS = 5;

  static const double MIN_DISTANCE_BETWEEN_POSITIONS = 2.5;

  static const String WARNING_MESSAGE_IMAGE_EXISTS_WITHOUT_DATA =
      'WARNING:  Image exists but data is null. This should never happen.';
}
