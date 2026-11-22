import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_lingo_user_app/main.dart';

void main() {
  testWidgets('shows home chrome and content', (WidgetTester tester) async {
    await tester.pumpWidget(const AiLingoApp());

    expect(find.text('AI-Lingo.'), findsOneWidget);
    expect(find.text('Hey, Alex 👋'), findsOneWidget);
    expect(find.text('Your daily momentum'), findsOneWidget);
    expect(find.text('Start Practicing'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Practice'), findsOneWidget);
    expect(find.text('Vocabulary'), findsOneWidget);
    expect(find.text('Progress'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('bottom navigation updates selected tab', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AiLingoApp());

    await tester.tap(find.text('Practice'));
    await tester.pump();

    // Home content remains until other features are implemented.
    expect(find.text('Hey, Alex 👋'), findsOneWidget);
    expect(find.text('Practice'), findsOneWidget);
  });

  testWidgets('opens leaderboard from home rank shortcut', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AiLingoApp());

    await tester.tap(find.text('#12'));
    await tester.pumpAndSettle();

    expect(find.text('Leaderboard'), findsOneWidget);
    expect(find.text('Weekly'), findsOneWidget);
    expect(find.text('Overall'), findsOneWidget);
    expect(find.text('Sofia'), findsOneWidget);
    expect(find.textContaining("THIS WEEK'S STARS"), findsOneWidget);

    await tester.tap(find.text('Overall'));
    await tester.pump();
    expect(find.text('ALL-TIME ACHIEVERS'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Alex Carter'),
      80,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Alex Carter'), findsOneWidget);
    expect(find.text('You · Keep climbing!'), findsOneWidget);
  });
}
