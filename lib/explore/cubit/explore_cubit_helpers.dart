// ignore_for_file: invalid_use_of_protected_member,
// ignore_for_file: invalid_use_of_visible_for_testing_member

part of 'explore_cubit.dart';

/// Handles the tracking positions and managing the state and persistance
///
/// This cubit is responsible for tracking the user's position and saving the
/// data to the repository.
extension ExploreCubitHelpers on ExploreCubit {
  /// Handles the permissions required to get the current position
  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();

    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    if (!serviceEnabled) return false;

    // Check for user permission
    permission = await _geolocatorPlatform.checkPermission();

    // Permissions are denied, next time you could try
    // requesting permissions again (this is also where
    // Android's shouldShowRequestPermissionRationale
    // returned true. According to Android guidelines
    // your App should show an explanatory UI now.
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    // Permissions are denied forever, handle appropriately.
    if (permission == LocationPermission.deniedForever) return false;

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    if (permission != LocationPermission.always) {
      permission = await _geolocatorPlatform.requestPermission();
    }

    return true;
  }

  /// Handles converting the current position to a [LatLng] to be saved on the
  /// fog image.
  PixelImage _latLngToPixel(LatLng userCoordinates) {
    // Normalize the coordinate to a value between 0 and 1
    final normalizedLat =
        (userCoordinates.latitude - Constants.BROOKLYN_NORTH_WEST.latitude) /
            (Constants.BROOKLYN_SOUTH_EAST.latitude -
                Constants.BROOKLYN_NORTH_WEST.latitude);

    final normalizedLng =
        (userCoordinates.longitude - Constants.BROOKLYN_NORTH_WEST.longitude) /
            (Constants.BROOKLYN_SOUTH_EAST.longitude -
                Constants.BROOKLYN_NORTH_WEST.longitude);

    // If the normalized values are outside the range (0, 1), return -1
    if (normalizedLat < 0 ||
        normalizedLat > 1 ||
        normalizedLng < 0 ||
        normalizedLng > 1) {
      return PixelImage(-1, -1);
    }

    // Map the normalized values to the resolution of the image
    final pixelX = normalizedLng * Constants.IMG_WIDTH;
    final pixelY = normalizedLat * Constants.IMG_HEIGHT;

    return PixelImage(pixelX, pixelY);
  }

  repository_position.Position _toRepositoryPosition(LatLng userCoordinates) {
    return repository_position.Position(
      latitude: userCoordinates.latitude,
      longitude: userCoordinates.longitude,
      createdAt: DateTime.now(),
    );
  }

  /// Helper to toggle the [AlignOnUpdate] state.
  void toggleAlignPositionOnUpdate() {
    emit(
      state.copyWith(alignPositionOnUpdate: AlignOnUpdate.never),
    );
  }
}
