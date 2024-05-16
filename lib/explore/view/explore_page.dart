import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:run_to_claim/app/widgets/drawer.dart';
import 'package:run_to_claim/constants.dart';
import 'package:run_to_claim/explore/explore.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});
  const ExplorePage._();

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const ExplorePage._());
  }

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  late StreamSubscription<Position> _positionStream;

  final locationSettings = const LocationSettings(
    distanceFilter: 50,
    accuracy: LocationAccuracy.medium,
  );

  @override
  void initState() {
    super.initState();

    _positionStream = _geolocatorPlatform
        .getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) => handleLocationEvent);
  }

  @override
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }

  Future<void> handleLocationEvent(Position? position) async {
    if (position == null) return;

    _positionStream.pause();

    final eventPosition = LatLng(position.latitude, position.longitude);
    await context.read<ExploreCubit>().onPositionChanged(eventPosition);

    _positionStream.resume();
  }

  @override
  Widget build(BuildContext context) {
    return const ExploreView();
  }
}

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        if (state.fogImage == null) {
          context.read<ExploreCubit>().getCurrentPosition(forceUpdate: true);
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Explore')),
          drawer: const NavDrawer(),
          body: Stack(
            children: [
              // MAP
              FlutterMap(
                options: MapOptions(
                  initialCenter: state.currentPosition,
                  initialZoom: Constants.DEFAULT_ZOOM,
                  //keepAlive: true,
                  onPositionChanged: (MapPosition position, bool hasGesture) {
                    // Check if auto align is enabled.
                    final autoAlignEnabled =
                        state.alignPositionOnUpdate != AlignOnUpdate.never;

                    // If there is no gesture or auto align is disabled, return.
                    if (!hasGesture || !autoAlignEnabled) return;

                    // disable auto align.
                    context.read<ExploreCubit>().toggleAlignPositionOnUpdate();
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: Constants.MAP_TILE_URL,
                  ),
                  if (state.fogImage != null)
                    FogOfWarLayerWidget(
                      state: MapScreenData(
                        markerLocation: state.currentPosition,
                        updatedFogImage: state.fogImageData,
                      ),
                    ),
                  CurrentLocationLayer(
                    alignPositionOnUpdate: state.alignPositionOnUpdate,
                  ),
                ],
              ),
              // LOADING INDICATOR
              if (state.mapStatus == MapStatus.loading)
                const SizedBox.expand(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.white,
            onPressed: () async {
              await context
                  .read<ExploreCubit>()
                  .getCurrentPosition(forceUpdate: true);
            },
            child: const Icon(Icons.location_on),
          ),
        );
      },
    );
  }
}
