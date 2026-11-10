import 'package:flutter_test/flutter_test.dart';

import 'package:ai_lingo_user_app/main.dart';

void main() {
  testWidgets('shows AI Lingo title', (WidgetTester tester) async {
    await tester.pumpWidget(const AiLingoApp());

    expect(find.text('AI Lingo'), findsOneWidget);
    expect(find.text('Learn languages with AI'), findsOneWidget);
  });
}
