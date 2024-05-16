import 'dart:ui' as ui;

import 'package:explore_repository/explore_repository.dart'
    as repository_position show Position;
import 'package:explore_repository/explore_repository.dart' hide Position;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:run_to_claim/constants.dart';
import 'package:run_to_claim/explore/explore.dart';

part 'explore_cubit_fog.dart';
part 'explore_cubit_helpers.dart';

class ExploreCubit extends Cubit<ExploreState> with HydratedMixin {
  ExploreCubit(
    this._exploreRepository, {
    GeolocatorPlatform? geolocatorPlatform,
  })  : _geolocatorPlatform = geolocatorPlatform ?? GeolocatorPlatform.instance,
        super(ExploreState());

  final ExploreRepository _exploreRepository;
  final GeolocatorPlatform _geolocatorPlatform;

  Future<void> init() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) return;

    emit(
      state.copyWith(
        mapStatus: MapStatus.loading,
      ),
    );

    await getPastPositions();
    await initializeFog();
  }

  Future<void> getCurrentPosition({bool? forceUpdate = false}) async {
    // Prepare the loading state. This should show the loading indicator and
    // align the map to the current position.
    emit(
      state.copyWith(
        mapStatus: MapStatus.loading,
        alignPositionOnUpdate: AlignOnUpdate.always,
      ),
    );

    // Check Permissions
    final hasPermission = await _handlePermission();
    if (!hasPermission) return;

    // Get current Position.
    final position = await _geolocatorPlatform.getCurrentPosition();
    final currentPosition = LatLng(position.latitude, position.longitude);

    // If the position is the same as the current position, do nothing.
    // Unless [forceUpdate] is true.
    if ((forceUpdate ?? false) || (currentPosition != state.currentPosition)) {
      final updatedPositions = state.pastPositions.toSet()
        ..add(currentPosition);

      emit(
        state.copyWith(
          currentPosition: currentPosition,
          pastPositions: updatedPositions,
        ),
      );
      await updatePastPositions();
      await updateFog();
    }

    // Prepare the complete state.
    emit(
      state.copyWith(
        mapStatus: MapStatus.success,
      ),
    );
  }

  Future<void> onPositionChanged(LatLng? userCoordinates) async {
    final previousPosition = state.currentPosition;

    // Invalid coordinates, do nothing.
    if (userCoordinates == null) return;

    // Same coordinates, do nothing.
    if (previousPosition.latitude == userCoordinates.latitude &&
        previousPosition.longitude == userCoordinates.longitude) return;

    // calculate the distance between the previous and the new position
    final distanceInMeters = Geolocator.distanceBetween(
      previousPosition.latitude,
      previousPosition.longitude,
      userCoordinates.latitude,
      userCoordinates.longitude,
    );

    if (distanceInMeters > Constants.MIN_DISTANCE_BETWEEN_POSITIONS) {
      await getCurrentPosition();
      debugPrint('Position updated (Was $distanceInMeters meters away)');
    }
  }

  Future<void> getPastPositions() async {
    final positions = await _exploreRepository.getPositions();
    final pastPositions = positions.map((pos) {
      return LatLng(pos.latitude, pos.longitude);
    }).toSet();

    debugPrint('Past positions loaded: ${pastPositions.length}');
    emit(state.copyWith(pastPositions: pastPositions));
  }

  Future<void> updatePastPositions() async {
    //final pastPositions = state.pastPositions;
    //emit(state.copyWith(pastPositions: pastPositions));
    final position = _toRepositoryPosition(state.currentPosition);
    await _exploreRepository.addPosition(position);
  }

  /// Returns ExploreState from JSON for hydrated_bloc.
  ///
  /// [ExploreState.fogImage] is not saved as json and needs to be
  /// recreated from [ExploreState.fogImageData] on [updateFog].
  /// This is done asynchronously and will emit when the image is ready.
  @override
  ExploreState fromJson(Map<String, dynamic> json) {
    final cubitState = ExploreState.fromJson(json);

    // Async operation to recreate the image from the data.
    if (cubitState.fogImageData != null) updateFog();

    return cubitState;
  }

  /// Returns JSON from ExploreState for hydrated_bloc.
  ///
  /// [ExploreState.fogImage] is not saved as json and needs to be
  /// recreated from [ExploreState.fogImageData] when getting fromJSON.
  @override
  Map<String, dynamic> toJson(ExploreState state) {
    return state.toJson();
  }
}
