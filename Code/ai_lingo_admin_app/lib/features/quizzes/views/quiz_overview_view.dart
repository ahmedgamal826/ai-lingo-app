import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../models/quiz_models.dart';
import '../widgets/quiz_action_button.dart';
import '../widgets/quiz_chip.dart';
import '../widgets/quiz_info_box.dart';
import '../widgets/quiz_overview_details_card.dart';
import '../widgets/quiz_scaffold.dart';
import '../widgets/quiz_stats_card.dart';
import 'quiz_form_view.dart';
import 'quiz_question_view.dart';
import 'quiz_results_view.dart';

/// Quiz overview (detail) screen.
class QuizOverviewView extends StatelessWidget {
  const QuizOverviewView({super.key, required this.quiz});

  final Quiz quiz;

  static String _statusText(QuizStatus status) => switch (status) {
    QuizStatus.scheduled => 'Scheduled',
    QuizStatus.closed => 'Closed',
    QuizStatus.draft => 'Draft',
  };

  @override
  Widget build(BuildContext context) {
    final isClosed = quiz.status == QuizStatus.closed;

    return QuizScaffold(
      title: 'Quiz overview',
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuizChip(quiz.week),
              Text(
                _statusText(quiz.status),
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            quiz.title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 6.h),
          // Temporary sample text. The Cubit will provide the real values.
          Text(
            'Grammar, vocabulary, and expressions for real-life conversations.',
            style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary),
          ),
          SizedBox(height: 16.h),
          const QuizOverviewDetailsCard(
            rows: [
              QuizDetailRow(
                iconName: 'graduation-cap',
                title: 'B1 Intermediate',
                subtitle: '20 questions · 100 total points',
              ),
              QuizDetailRow(
                iconName: 'clock',
                title: '20 minutes · 1 attempt',
              ),
              QuizDetailRow(
                iconName: 'calendar',
                title: 'Nov 13, 9:00 AM',
                subtitle: 'Closed Nov 15, 8:00 PM · UTC',
              ),
            ],
          ),
          if (isClosed) ...[
            SizedBox(height: 12.h),
            const QuizStatsCard(
              headline: '182 submissions',
              highlight: '78% avg. score',
              footnote: 'Published by Jamie Morgan · Nov 10',
            ),
            SizedBox(height: 12.h),
            QuizActionButton.primary(
              label: 'View Results & Scores',
              iconName: 'trophy',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) =>
                      QuizResultsView(week: quiz.week, title: quiz.title),
                ),
              ),
            ),
          ],
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: QuizActionButton.light(
                  label: 'Edit Quiz',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => QuizFormView.edit(quiz: quiz),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: QuizActionButton.light(
                  label: 'Edit Questions',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => QuizQuestionView.edit(
                        week: quiz.week,
                        title: quiz.title,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isClosed) ...[
            SizedBox(height: 12.h),
            const QuizInfoBox(
              iconName: 'shield-check',
              title: 'Closed test',
              message:
              'Changes to the answer key may affect results. Review scores after editing.',
            ),
          ],
        ],
      ),
    );
  }
}