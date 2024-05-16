import 'dart:math';

import 'package:explore_repository/explore_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latlong2/latlong.dart';

class ExploreRepository {
  ExploreRepository();

  late Box<Position> positionBox;

  /// Initialize the repository.
  ///
  /// [reset] will delete all positions from the box. Does not affect dummy.
  /// [useDummy] will use a dummy box with fake positions. This will create a
  /// random list of positions and reset it when this is reinitialized.
  Future<void> init({bool reset = false, bool useDummy = false}) async {
    await Hive.initFlutter();

    Hive.registerAdapter(PositionAdapter());

    positionBox = await Hive.openBox<Position>('positions');
    if (reset) await deleteAllPositions();

    if (!useDummy) return;

    // if [useDummy] is true, then close the current box and open a dummy one
    await positionBox.close();
    positionBox = await Hive.openBox<Position>('dummyPositions');

    await resetWithDummy();
  }

  Future<void> addPosition(Position position) async {
    // Check if the position already exists
    // This will only check for the exact same position.
    final positionExists = positionBox.values
        .toList()
        .where(
          (pos) =>
              (pos.latitude == position.latitude) &&
              (pos.longitude == position.longitude),
        )
        .isNotEmpty;
    if (positionExists) return;

    await positionBox.add(position);
  }

  /// Returns a list of positions within the given bounds.
  ///
  /// If [topLeft] and [bottomRight] are provided, only positions within the
  /// bounds or all will be return if left empty.
  Future<List<Position>> getPositions({
    LatLng? topLeft,
    LatLng? bottomRight,
  }) async {
    final positions = positionBox.values.toList();

    // Filter positions by bounds
    if (topLeft != null && bottomRight != null) {
      positions.retainWhere((position) {
        return position.latitude >= bottomRight.latitude &&
            position.latitude <= topLeft.latitude &&
            position.longitude >= topLeft.longitude &&
            position.longitude <= bottomRight.longitude;
      });
    }

    return positions;
  }

  /// Delete all positions from the box.
  ///
  /// This is used for testing purposes.
  Future<void> deleteAllPositions() async {
    await positionBox.clear();
  }

  Future<void> resetWithDummy() async {
    final center = Position(latitude: 40.7128, longitude: -74.0060);
    const randomOffset = 0.005; // Adjust the offset range as needed

    await positionBox.clear();
    await positionBox.add(center);

    double getRandomLatitude(double originalLatitude) {
      final random = Random();
      final offset = (random.nextDouble() * randomOffset) - randomOffset / 2;
      return originalLatitude + offset;
    }

    double getRandomLongitude(double originalLongitude) {
      final random = Random();
      final offset = (random.nextDouble() * randomOffset) - randomOffset / 2;
      return originalLongitude + offset;
    }

    for (var i = 0; i < 10; i++) {
      await positionBox.add(
        Position(
          latitude: getRandomLatitude(center.latitude),
          longitude: getRandomLongitude(center.longitude),
        ),
      );
    }
  }
}
