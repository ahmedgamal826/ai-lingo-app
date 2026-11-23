import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../models/quiz_models.dart';
import '../widgets/quiz_action_button.dart';
import '../widgets/quiz_info_box.dart';
import '../widgets/quiz_learner_header_card.dart';
import '../widgets/quiz_scaffold.dart';
import '../widgets/quiz_text_field.dart';
import 'quiz_score_updated_view.dart';

/// Adjust Score: change one learner's score with a required reason.
///
/// Confirming replaces this screen with "Score updated" and sends the
/// updated learner back to Test Results.
class QuizAdjustScoreView extends StatefulWidget {
  const QuizAdjustScoreView({
    super.key,
    required this.week,
    required this.title,
    required this.learner,
  });

  /// e.g. "Week 46"
  final String week;

  /// e.g. "Everyday English"
  final String title;
  final QuizLearnerResult learner;

  @override
  State<QuizAdjustScoreView> createState() => _QuizAdjustScoreViewState();
}

class _QuizAdjustScoreViewState extends State<QuizAdjustScoreView> {
  late final TextEditingController _score;
  late final TextEditingController _reason;

  @override
  void initState() {
    super.initState();
    _score = TextEditingController(text: '${widget.learner.score}');
    _reason = TextEditingController(text: widget.learner.reason);
    _score.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _score.dispose();
    _reason.dispose();
    super.dispose();
  }

  int? get _newScore {
    final value = int.tryParse(_score.text.trim());
    if (value == null || value < 0 || value > 100) return null;
    return value;
  }

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _confirm() {
    final newScore = _newScore;
    if (newScore == null) {
      _message('Enter a score between 0 and 100.');
      return;
    }
    final reason = _reason.text.trim();
    if (reason.isEmpty) {
      _message('Please add a reason for the adjustment.');
      return;
    }

    final updated = widget.learner.adjustedTo(newScore, reason);
    Navigator.of(context).pushReplacement<void, QuizLearnerResult>(
      MaterialPageRoute<void>(
        builder: (_) => QuizScoreUpdatedView(
          week: widget.week,
          learner: updated,
          fromScore: widget.learner.originalScore,
        ),
      ),
      result: updated,
    );
  }

  @override
  Widget build(BuildContext context) {
    final learner = widget.learner;
    final from = learner.originalScore;
    final to = _newScore?.toString() ?? '—';

    return QuizScaffold(
      title: 'Adjust Score',
      subtitle: '${widget.week.toUpperCase()} · ${widget.title.toUpperCase()}',
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        children: [
          QuizLearnerHeaderCard(
            initials: learner.initials,
            name: learner.name,
            email: learner.email,
            currentScore: from,
            // TODO: the real complaint id comes from the Cubit.
            tag: '#C-1042',
          ),
          SizedBox(height: 16.h),
          QuizTextField(
            label: 'New score (0–100)',
            controller: _score,
            suffixIconName: 'pencil',
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16.h),
          QuizTextField(
            label: 'Reason for adjustment',
            controller: _reason,
            hint: 'Explain why this score is being changed',
            minLines: 4,
            maxLines: 5,
          ),
          SizedBox(height: 6.h),
          Text(
            'Required · visible in the activity log.',
            style: TextStyle(fontSize: 9.sp, color: AppColors.textSecondary),
          ),
          SizedBox(height: 16.h),
          QuizInfoBox(
            iconName: 'shield-check',
            title: 'Confirm this score change',
            message:
            "${learner.firstName}'s score will change from $from to $to. Their quiz results and leaderboard points will update, and a notification will be sent.",
          ),
          SizedBox(height: 24.h),
          QuizActionButton.primary(
            label: 'Confirm Score Adjustment',
            onTap: _confirm,
          ),
          SizedBox(height: 12.h),
          QuizActionButton.light(
            label: 'Cancel',
            onTap: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    );
  }
}