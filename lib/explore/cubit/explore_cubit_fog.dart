// ignore_for_file: invalid_use_of_protected_member,
// ignore_for_file: invalid_use_of_visible_for_testing_member

part of 'explore_cubit.dart';

/// Handles the creating and managing the fog image
///
/// This cubit is responsible for creating the fog image and updating it
extension ExploreCubitFog on ExploreCubit {
  /// Load empty image and load past positions
  Future<void> initializeFog({bool updatePastPositions = true}) async {
    final data = await rootBundle.load(Constants.FOG_IMAGE_FILE);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frameInfo = await codec.getNextFrame();

    var fogImage = frameInfo.image;

    if (updatePastPositions && state.pastPositions.isNotEmpty) {
      for (final pastPosition in state.pastPositions) {
        // Update the fog image with each past position and use it in the next
        fogImage = await setFogImage(fogImage, position: pastPosition);
      }
    }

    // Set current location
    await setFogImage(fogImage);
  }

  /// Updates the fog image based on the state of the cubit
  ///
  /// This handles cases like when the hydrated cubit is hydrating or other
  /// in between states. (Probably should incorporate states here... )
  /// If neither the [ExploreState.fogImage] nor [ExploreState.fogImageData]
  /// is set, we assume that it should import a brand new fog image.
  Future<void> updateFog() async {
    // Image already exists and can be processed.
    if (state.fogImage != null && state.fogImageData != null) {
      await setFogImage(state.fogImage!);
      return;
    }

    // Image Data exists but image does not. This could happen when
    // bloc is rehydrated.
    if (state.fogImage == null && state.fogImageData != null) {
      final codec = await ui
          .instantiateImageCodec(state.fogImageData!.buffer.asUint8List());
      final frameInfo = await codec.getNextFrame();
      await setFogImage(frameInfo.image);
      return;
    }

    if (state.fogImage == null && state.fogImageData == null) {
      await initializeFog();
      return;
    }

    // WARNING: Image exists but data is null. This should never happen.
    // Right now, this will return nothing but it could load the default image.
    debugPrint(Constants.WARNING_MESSAGE_IMAGE_EXISTS_WITHOUT_DATA);
    return;
  }

  /// Sets the fog image based on the
  Future<ui.Image> setFogImage(ui.Image fogImage, {LatLng? position}) async {
    position ??= state.currentPosition;

    final coordinatesToPixel = _latLngToPixel(position);

    final updatedFogImage = await modifyImage(
      coordinatesToPixel.x,
      coordinatesToPixel.y,
      fogImage,
    );

    // Convert the image to a format that can be used with OverlayImageLayer.
    final byteData =
        await updatedFogImage.toByteData(format: ui.ImageByteFormat.png);

    final updatedPositions = state.pastPositions.toSet()..add(position);

    emit(
      state.copyWith(
        fogImage: updatedFogImage,
        fogImageData: byteData!.buffer.asUint8List(),
        pastPositions: updatedPositions,
      ),
    );

    return updatedFogImage;
  }

  /// Updates the fog image by removing the overlay at the given coordinates
  ///
  /// This function takes the current fog image and removes the overlay at the
  /// given coordinates. The overlay is a circle with a radius of
  /// [Constants.EXPLORATION_RADIUS_IN_METERS]
  Future<ui.Image> modifyImage(double x, double y, ui.Image image) async {
    const explorationRadiusInMeters = Constants.EXPLORATION_RADIUS_IN_METERS;

    const widthImage = Constants.IMG_WIDTH;
    const heightImage = Constants.IMG_HEIGHT;

    // Create a canvas and draw the image on it.
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder)
      ..drawImage(image, Offset.zero, Paint());

    // Create a second canvas and draw the mask on it.
    final maskRecorder = ui.PictureRecorder();
    Canvas(maskRecorder);
    maskRecorder.endRecording();

    canvas.drawOval(
      Rect.fromLTWH(
        x - (explorationRadiusInMeters / 2),
        y - (explorationRadiusInMeters / 2),
        explorationRadiusInMeters,
        explorationRadiusInMeters,
      ),
      Paint()..blendMode = BlendMode.dstOut,
    );

    // Convert the canvas back to an image.
    final picture = pictureRecorder.endRecording();
    final updatedFogImage = await picture.toImage(widthImage, heightImage);

    return updatedFogImage;
  }
}
