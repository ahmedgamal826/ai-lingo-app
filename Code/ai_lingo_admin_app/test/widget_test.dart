import 'package:flutter_test/flutter_test.dart';

import 'package:ai_lingo_admin_app/main.dart';

void main() {
  testWidgets('shows AI Lingo Admin title', (WidgetTester tester) async {
    await tester.pumpWidget(const AiLingoAdminApp());

    expect(find.text('AI Lingo Admin'), findsOneWidget);
    expect(find.text('Manage AI Lingo content'), findsOneWidget);
  });
}
