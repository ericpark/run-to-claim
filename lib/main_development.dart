import 'package:explore_repository/explore_repository.dart';
import 'package:flutter/material.dart';
import 'package:run_to_claim/app/app.dart';
import 'package:run_to_claim/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final exploreRepository = ExploreRepository();
  await exploreRepository.init(useDummy: true);

  await bootstrap(() => App(exploreRepository: exploreRepository));
}
