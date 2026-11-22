import 'package:flutter/material.dart';

enum WeeklyTestStatus { locked, active, closed }

class WeeklyTestInfoRow {
  const WeeklyTestInfoRow({
    required this.iconAsset,
    required this.title,
    this.subtitle,
  });

  final String iconAsset;
  final String title;
  final String? subtitle;
}

class WeeklyTestMessage {
  const WeeklyTestMessage({
    required this.iconAsset,
    required this.title,
    required this.body,
  });

  final String iconAsset;
  final String title;
  final String body;
}

/// Mock-friendly weekly test presentation model.
class WeeklyTestInfo {
  const WeeklyTestInfo({
    required this.title,
    required this.description,
    required this.opensAt,
    required this.closesAt,
    required this.scheduleTitle,
    required this.scheduleSubtitle,
    required this.durationTitle,
    required this.durationSubtitle,
    required this.attemptsAvailableLabel,
    required this.attemptsUsedLabel,
    required this.lockedMessage,
    required this.activeMessage,
    required this.closedMessage,
    required this.lockedButtonLabel,
    required this.activeButtonLabel,
    required this.closedButtonLabel,
    required this.endedAtLabel,
    this.scoreLabel,
    this.pointsEarnedLabel,
  });

  final String title;
  final String description;
  final DateTime opensAt;
  final DateTime closesAt;
  final String scheduleTitle;
  final String scheduleSubtitle;
  final String durationTitle;
  final String durationSubtitle;
  final String attemptsAvailableLabel;
  final String attemptsUsedLabel;
  final WeeklyTestMessage lockedMessage;
  final WeeklyTestMessage activeMessage;
  final WeeklyTestMessage closedMessage;
  final String lockedButtonLabel;
  final String activeButtonLabel;
  final String closedButtonLabel;
  final String endedAtLabel;
  final String? scoreLabel;
  final String? pointsEarnedLabel;

  WeeklyTestStatus statusAt(DateTime now) {
    if (now.isBefore(opensAt)) return WeeklyTestStatus.locked;
    if (now.isBefore(closesAt)) return WeeklyTestStatus.active;
    return WeeklyTestStatus.closed;
  }

  Duration remainingUntilOpen(DateTime now) {
    final diff = opensAt.difference(now);
    return diff.isNegative ? Duration.zero : diff;
  }

  Duration remainingUntilClose(DateTime now) {
    final diff = closesAt.difference(now);
    return diff.isNegative ? Duration.zero : diff;
  }

  WeeklyTestInfo copyWith({
    String? title,
    String? description,
    DateTime? opensAt,
    DateTime? closesAt,
    String? scheduleTitle,
    String? scheduleSubtitle,
    String? durationTitle,
    String? durationSubtitle,
    String? attemptsAvailableLabel,
    String? attemptsUsedLabel,
    WeeklyTestMessage? lockedMessage,
    WeeklyTestMessage? activeMessage,
    WeeklyTestMessage? closedMessage,
    String? lockedButtonLabel,
    String? activeButtonLabel,
    String? closedButtonLabel,
    String? endedAtLabel,
    String? scoreLabel,
    String? pointsEarnedLabel,
  }) {
    return WeeklyTestInfo(
      title: title ?? this.title,
      description: description ?? this.description,
      opensAt: opensAt ?? this.opensAt,
      closesAt: closesAt ?? this.closesAt,
      scheduleTitle: scheduleTitle ?? this.scheduleTitle,
      scheduleSubtitle: scheduleSubtitle ?? this.scheduleSubtitle,
      durationTitle: durationTitle ?? this.durationTitle,
      durationSubtitle: durationSubtitle ?? this.durationSubtitle,
      attemptsAvailableLabel:
          attemptsAvailableLabel ?? this.attemptsAvailableLabel,
      attemptsUsedLabel: attemptsUsedLabel ?? this.attemptsUsedLabel,
      lockedMessage: lockedMessage ?? this.lockedMessage,
      activeMessage: activeMessage ?? this.activeMessage,
      closedMessage: closedMessage ?? this.closedMessage,
      lockedButtonLabel: lockedButtonLabel ?? this.lockedButtonLabel,
      activeButtonLabel: activeButtonLabel ?? this.activeButtonLabel,
      closedButtonLabel: closedButtonLabel ?? this.closedButtonLabel,
      endedAtLabel: endedAtLabel ?? this.endedAtLabel,
      scoreLabel: scoreLabel ?? this.scoreLabel,
      pointsEarnedLabel: pointsEarnedLabel ?? this.pointsEarnedLabel,
    );
  }
}

class WeeklyTestStatusStyle {
  const WeeklyTestStatusStyle({
    required this.badgeLabel,
    required this.badgeBackground,
    required this.badgeForeground,
    required this.statusIconAsset,
    required this.countdownLabel,
  });

  final String badgeLabel;
  final Color badgeBackground;
  final Color badgeForeground;
  final String statusIconAsset;
  final String countdownLabel;
}
