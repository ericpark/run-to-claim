import 'package:explore_repository/explore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:run_to_claim/counter/counter.dart';
import 'package:run_to_claim/explore/explore.dart';
import 'package:run_to_claim/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({
    required ExploreRepository exploreRepository,
    super.key,
  }) : _exploreRepository = exploreRepository;

  final ExploreRepository _exploreRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _exploreRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ExploreCubit>(
            lazy: false,
            create: (BuildContext context) => ExploreCubit(
              context.read<ExploreRepository>(),
              geolocatorPlatform: GeolocatorPlatform.instance,
            )..init(),
          ),
          BlocProvider<CounterCubit>(
            create: (BuildContext context) => CounterCubit(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ExplorePage(),
        ),
      ),
    );
  }
}
