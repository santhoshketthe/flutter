import 'package:flutter/material.dart';
import 'package:flutter_project/set_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('integration testing', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp( home: Counter()));
    expect(find.text('Count: 0'), findsOneWidget);
    expect(find.text('Count: 1'), findsNothing);

    await tester.tap(find.byKey(const Key('incrementButton')));
    await tester.pumpAndSettle();

    expect(find.text('Count: 1'), findsOneWidget);
    expect(find.text('Count: 0'), findsNothing);

    await tester.tap(find.byKey(const Key('decrementButton')));
    await tester.pumpAndSettle();

    expect(find.text('Count: 0'), findsOneWidget);
    expect(find.text('Count: -1'), findsNothing);

    await tester.tap(find.byKey(const Key('decrementButton')));
    await tester.pumpAndSettle();

    expect(find.text('Count: -1'), findsOneWidget);
    expect(find.text('Count: 0'), findsNothing);
  });
}