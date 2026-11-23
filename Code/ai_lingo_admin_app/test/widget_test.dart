import 'package:ai_lingo_admin_app/features/profile/admin_profile_feature.dart';
import 'package:ai_lingo_admin_app/features/shell/views/main_shell_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows admin shell navigation', (WidgetTester tester) async {
    await tester.pumpWidget(
      AdminProfileFeatureProvider(
        child: ScreenUtilInit(
          designSize: const Size(360, 800),
          builder: (context, child) {
            return const MaterialApp(home: MainShellView());
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Complaints'), findsWidgets);
  });
}
