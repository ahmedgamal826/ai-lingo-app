import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../core/widgets/custom_button.dart';
import '../models/weekly_test_models.dart';
import 'weekly_test_information_card.dart';
import 'weekly_test_message_card.dart';
import 'weekly_test_status_card.dart';

class WeeklyTestPanel extends StatelessWidget {
  const WeeklyTestPanel({
    super.key,
    required this.info,
    required this.status,
    required this.countdown,
    required this.onPrimaryAction,
  });

  final WeeklyTestInfo info;
  final WeeklyTestStatus status;
  final Duration countdown;
  final VoidCallback onPrimaryAction;

  WeeklyTestMessage get _message {
    switch (status) {
      case WeeklyTestStatus.locked:
        return info.lockedMessage;
      case WeeklyTestStatus.active:
        return info.activeMessage;
      case WeeklyTestStatus.closed:
        return info.closedMessage;
    }
  }

  String get _buttonLabel {
    switch (status) {
      case WeeklyTestStatus.locked:
        return info.lockedButtonLabel;
      case WeeklyTestStatus.active:
        return info.activeButtonLabel;
      case WeeklyTestStatus.closed:
        return info.closedButtonLabel;
    }
  }

  bool get _isButtonEnabled => status != WeeklyTestStatus.locked;

  List<WeeklyTestInfoRow> get _rows => [
    WeeklyTestInfoRow(
      iconAsset: AppAssets.calendarDays,
      title: info.scheduleTitle,
      subtitle: info.scheduleSubtitle,
    ),
    WeeklyTestInfoRow(
      iconAsset: AppAssets.timer,
      title: info.durationTitle,
      subtitle: info.durationSubtitle,
    ),
    WeeklyTestInfoRow(
      iconAsset: AppAssets.rotateCcw,
      title: status == WeeklyTestStatus.closed
          ? info.attemptsUsedLabel
          : info.attemptsAvailableLabel,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WeeklyTestStatusCard(
          status: status,
          title: info.title,
          description: info.description,
          countdown: countdown,
          endedAtLabel: info.endedAtLabel,
        ),
        const SizedBox(height: AppDimensions.spaceMd),
        WeeklyTestInformationCard(rows: _rows),
        const SizedBox(height: AppDimensions.spaceMd),
        WeeklyTestMessageCard(message: _message),
        const Spacer(),
        CustomButton(
          title: _buttonLabel,
          isEnabled: _isButtonEnabled,
          height: 50,
          backgroundColor: _isButtonEnabled
              ? AppColors.primary
              : AppColors.indicatorInactive,
          foregroundColor: _isButtonEnabled
              ? AppColors.white
              : AppColors.textSecondary,
          onPressed: _isButtonEnabled ? onPrimaryAction : null,
        ),
      ],
    );
  }
}
