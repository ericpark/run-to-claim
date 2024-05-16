import 'package:explore_repository/explore_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:run_to_claim/app/app.dart';
import 'package:run_to_claim/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(
        App(
          exploreRepository: ExploreRepository(),
        ),
      );
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
