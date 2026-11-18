import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../models/quiz_models.dart';
import '../widgets/quiz_action_button.dart';
import '../widgets/quiz_answer_option.dart';
import '../widgets/quiz_chip.dart';
import '../widgets/quiz_dropdown.dart';
import '../widgets/quiz_scaffold.dart';
import '../widgets/quiz_svg_icon.dart';
import '../widgets/quiz_text_field.dart';
import 'quiz_schedule_view.dart';

/// Preview question / Edit question: one screen, two modes.
///
/// `QuizQuestionView.preview(...)` shows the question read-only,
/// `QuizQuestionView.edit(...)` lets the admin change it.
class QuizQuestionView extends StatefulWidget {
  const QuizQuestionView.preview({
    super.key,
    required this.week,
    required this.title,
  }) : isEdit = false;

  const QuizQuestionView.edit({
    super.key,
    required this.week,
    required this.title,
  }) : isEdit = true;

  /// e.g. "Week 47"
  final String week;

  /// e.g. "Travel with Confidence"
  final String title;
  final bool isEdit;

  @override
  State<QuizQuestionView> createState() => _QuizQuestionViewState();
}

class _QuizQuestionViewState extends State<QuizQuestionView> {
  static const List<String> _categories = [
    'Grammar',
    'Vocabulary',
    'Expressions',
  ];

  static const String _editHint =
      'Choose the sentence that correctly describes a past experience.';

  // Temporary sample data (match Figma). The Cubit will provide real data.
  static const QuizQuestion _previewSample = QuizQuestion(
    number: 1,
    total: 20,
    category: 'Expressions',
    points: 5,
    text: 'Which is the most polite way to make a hotel reservation?',
    options: [
      'I want room.',
      "I'd like to book a room, please.",
      'Give me room now.',
      'I booking room.',
    ],
    correctIndex: 1,
  );

  static const QuizQuestion _editSample = QuizQuestion(
    number: 8,
    total: 20,
    category: 'Grammar',
    points: 5,
    text: '',
    options: [
      'I have visited London last year.',
      'I visited London last year.',
      'I visit London last year.',
      'I had visit London last year.',
    ],
    correctIndex: 1,
  );

  late final QuizQuestion _sample;
  late final TextEditingController _question;
  late final TextEditingController _points;
  late final List<TextEditingController> _options;
  late String _category;
  late int _correct;

  @override
  void initState() {
    super.initState();
    _sample = widget.isEdit ? _editSample : _previewSample;
    _question = TextEditingController(text: _sample.text);
    _points = TextEditingController(text: '${_sample.points}');
    _options = [
      for (final answer in _sample.options)
        TextEditingController(text: answer),
    ];
    _category = _sample.category;
    _correct = _sample.correctIndex;
  }

  @override
  void dispose() {
    _question.dispose();
    _points.dispose();
    for (final controller in _options) {
      controller.dispose();
    }
    super.dispose();
  }

  void _openEdit() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            QuizQuestionView.edit(week: widget.week, title: widget.title),
      ),
    );
  }

  void _openSchedule() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            QuizScheduleView(week: widget.week, title: widget.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.isEdit;

    return QuizScaffold(
      title: isEdit ? 'Edit Question' : 'Preview Question',
      subtitle: '${widget.week.toUpperCase()} · ${widget.title.toUpperCase()}',
      trailing: IconButton(
        onPressed: isEdit ? () {} : _openEdit,
        icon: QuizSvgIcon(
          isEdit ? 'trash-2' : 'Edit',
          size: 22.w,
          color: AppColors.primary,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuizChip(
                'QUESTION ${_sample.number} OF ${_sample.total}',
                letterSpacing: 0.5,
              ),
              if (isEdit)
                Text(
                  '+ Add Question',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          // In preview mode the fields are visible but cannot be changed.
          IgnorePointer(
            ignoring: !isEdit,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: QuizDropdown(
                        label: 'Category',
                        value: _category,
                        items: _categories,
                        onChanged: (v) =>
                            setState(() => _category = v ?? _category),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: QuizTextField(
                        label: 'Points',
                        controller: _points,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                QuizTextField(
                  label: 'Question',
                  controller: _question,
                  hint: isEdit ? _editHint : null,
                  minLines: 3,
                  maxLines: 4,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Answer options · Select the correct answer',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                for (var i = 0; i < _options.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: QuizAnswerOption(
                      controller: _options[i],
                      selected: i == _correct,
                      onSelect: () => setState(() => _correct = i),
                    ),
                  ),
                Row(
                  children: [
                    Icon(Icons.check, size: 10.w, color: AppColors.success),
                    SizedBox(width: 4.w),
                    Text(
                      'Option ${String.fromCharCode(65 + _correct)} is the correct answer',
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: QuizActionButton.light(
                  label: 'Previous',
                  onTap: () => Navigator.of(context).maybePop(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: QuizActionButton.primary(
                  label: isEdit ? 'Save Question' : 'Next',
                  onTap: isEdit
                      ? () => Navigator.of(context).maybePop()
                      : _openSchedule,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}