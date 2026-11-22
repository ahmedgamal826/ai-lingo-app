import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../models/quiz_models.dart';
import '../widgets/quiz_learner_result_tile.dart';
import '../widgets/quiz_metric_tile.dart';
import '../widgets/quiz_scaffold.dart';
import '../widgets/quiz_svg_icon.dart';
import '../widgets/quiz_text_field.dart';
import 'quiz_adjust_score_view.dart';

/// Test Results: metrics, search, and the learner list.
class QuizResultsView extends StatefulWidget {
  const QuizResultsView({super.key, required this.week, required this.title});

  /// e.g. "Week 46"
  final String week;

  /// e.g. "Everyday English"
  final String title;

  @override
  State<QuizResultsView> createState() => _QuizResultsViewState();
}

class _QuizResultsViewState extends State<QuizResultsView> {
  // Temporary sample data (match Figma). The Cubit will provide real data.
  static const List<QuizLearnerResult> _initial = [
    QuizLearnerResult(
      name: 'Sofia Rivera',
      email: 'sofia.rivera@university.edu',
      initials: 'SR',
      score: 100,
      time: '12:08',
    ),
    QuizLearnerResult(
      name: 'Liam Parker',
      email: 'liam.parker@university.edu',
      initials: 'LP',
      score: 98,
      time: '13:42',
    ),
    QuizLearnerResult(
      name: 'Olivia Brown',
      email: 'olivia.brown@university.edu',
      initials: 'OB',
      score: 96,
      time: '15:21',
    ),
    QuizLearnerResult(
      name: 'Alex Carter',
      email: 'alex.carter@university.edu',
      initials: 'AC',
      score: 90,
      time: '14:32',
      adjustment: 5,
      reason:
      'Question 8: Answer key reviewed. Learner selected the correct past simple sentence. Awarded 5 points.',
    ),
    QuizLearnerResult(
      name: 'Mia Chen',
      email: 'mia.chen@university.edu',
      initials: 'MC',
      score: 88,
      time: '17:03',
    ),
    QuizLearnerResult(
      name: 'Ethan Brooks',
      email: 'ethan.brooks@university.edu',
      initials: 'EB',
      score: 85,
      time: '16:40',
    ),
  ];

  final TextEditingController _search = TextEditingController();
  List<QuizLearnerResult> _learners = List.of(_initial);
  bool _descending = true;

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<QuizLearnerResult> get _visible {
    final query = _search.text.trim().toLowerCase();
    final list = _learners.where((l) {
      return query.isEmpty ||
          l.name.toLowerCase().contains(query) ||
          l.email.toLowerCase().contains(query);
    }).toList();
    list.sort(
          (a, b) =>
      _descending ? b.score.compareTo(a.score) : a.score.compareTo(b.score),
    );
    return list;
  }

  Future<void> _adjust(QuizLearnerResult learner) async {
    final updated = await Navigator.of(context).push<QuizLearnerResult>(
      MaterialPageRoute<QuizLearnerResult>(
        builder: (_) => QuizAdjustScoreView(
          week: widget.week,
          title: widget.title,
          learner: learner,
        ),
      ),
    );
    if (updated == null || !mounted) return;
    setState(() {
      _learners = [
        for (final l in _learners) l.email == updated.email ? updated : l,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible;

    return QuizScaffold(
      title: 'Test Results',
      subtitle: '${widget.week.toUpperCase()} · ${widget.title.toUpperCase()}',
      trailing: IconButton(
        // TODO: export results (not in this batch).
        onPressed: () {},
        icon: QuizSvgIcon('download', size: 22.w, color: AppColors.primary),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        children: [
          // Temporary sample numbers. The Cubit will provide real values.
          Row(
            children: [
              const Expanded(
                child: QuizMetricTile(value: '182', label: 'Submissions'),
              ),
              SizedBox(width: 10.w),
              const Expanded(
                child: QuizMetricTile(value: '78%', label: 'Average'),
              ),
              SizedBox(width: 10.w),
              const Expanded(
                child: QuizMetricTile(value: '96%', label: 'Completion'),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          QuizTextField(
            label: 'Search learners',
            controller: _search,
            hint: 'Enter name or email',
            suffixIconName: 'search',
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Learner results',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() => _descending = !_descending),
                child: Text(
                  'Score ${_descending ? '↓' : '↑'}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (visible.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: Text(
                  'No learners match your search.',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            )
          else
            for (final learner in visible)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: QuizLearnerResultTile(
                  learner: learner,
                  onEdit: () => _adjust(learner),
                ),
              ),
          SizedBox(height: 8.h),
          Text(
            'Tap the edit icon to review and manually adjust a score. Every change is saved in the audit log.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9.sp, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}