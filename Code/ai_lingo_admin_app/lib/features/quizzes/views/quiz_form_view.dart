import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/quiz_models.dart';
import '../widgets/quiz_action_button.dart';
import '../widgets/quiz_chip.dart';
import '../widgets/quiz_dropdown.dart';
import '../widgets/quiz_info_box.dart';
import '../widgets/quiz_scaffold.dart';
import '../widgets/quiz_text_field.dart';
import 'quiz_question_view.dart';

/// Create quiz / Edit quiz: one form, two modes.
///
/// `QuizFormView.create()` for a new quiz,
/// `QuizFormView.edit(quiz: ...)` for an existing one.
class QuizFormView extends StatefulWidget {
  const QuizFormView.create({super.key}) : quiz = null;

  const QuizFormView.edit({super.key, required this.quiz});

  final Quiz? quiz;

  bool get isEdit => quiz != null;

  @override
  State<QuizFormView> createState() => _QuizFormViewState();
}

class _QuizFormViewState extends State<QuizFormView> {
  static const List<String> _levels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  late final TextEditingController _title;
  late final TextEditingController _description;
  late final TextEditingController _week;
  late final TextEditingController _duration;
  late final TextEditingController _attempts;
  String _level = 'B1';

  @override
  void initState() {
    super.initState();
    final quiz = widget.quiz;
    // Temporary sample values (match Figma). The Cubit will provide real data.
    _title = TextEditingController(
      text: quiz?.title ?? 'Travel with Confidence',
    );
    _description = TextEditingController(
      text: widget.isEdit
          ? 'Grammar, vocabulary, and expressions for real-life conversations.'
          : 'Practical English for airports, hotels, and exploring new places.',
    );
    _week = TextEditingController(
      text: quiz == null ? '47' : quiz.week.replaceFirst('Week ', ''),
    );
    _duration = TextEditingController(text: '20');
    _attempts = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _week.dispose();
    _duration.dispose();
    _attempts.dispose();
    super.dispose();
  }

  Future<void> _pickWeek() async {
    final current = int.tryParse(_week.text.trim()) ?? 1;
    final picked = await showModalBottomSheet<int>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: ListView.builder(
            itemCount: 52,
            itemBuilder: (_, i) {
              final week = i + 1;
              return ListTile(
                title: Text('Week $week'),
                selected: week == current,
                onTap: () => Navigator.of(sheetContext).pop(week),
              );
            },
          ),
        );
      },
    );
    if (picked != null) setState(() => _week.text = '$picked');
  }

  void _continueToQuestions() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => QuizQuestionView.preview(
          week: 'Week ${_week.text}',
          title: _title.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.isEdit;
    final chipLabel = isEdit
        ? '${widget.quiz!.week.toUpperCase()} · QUIZ DETAILS'
        : 'STEP 1 OF 3 · QUIZ DETAILS';

    return QuizScaffold(
      title: isEdit ? 'Edit Quiz' : 'Create Quiz',
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: QuizChip(chipLabel, letterSpacing: 0.5),
          ),
          SizedBox(height: 16.h),
          QuizTextField(label: 'Quiz title', controller: _title),
          SizedBox(height: 16.h),
          QuizTextField(
            label: 'Description',
            controller: _description,
            minLines: 3,
            maxLines: 4,
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: QuizTextField(
                  label: 'Week',
                  controller: _week,
                  suffixIconName: 'calendar',
                  readOnly: true,
                  onSuffixTap: _pickWeek,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: QuizDropdown(
                  label: 'English level',
                  value: _level,
                  items: _levels,
                  onChanged: (v) => setState(() => _level = v ?? _level),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: QuizTextField(
                  label: 'Duration (minutes)',
                  controller: _duration,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: QuizTextField(
                  label: 'Allowed attempts',
                  controller: _attempts,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (isEdit)
            const QuizInfoBox(
              iconName: 'shield-check',
              title: 'Edit with care',
              message:
              'This test has 182 submissions. Changes are recorded in the activity log.',
            )
          else
            const QuizInfoBox(
              iconName: 'clipboard-list',
              title: 'Next: build your questions',
              message:
              'Add 20 questions, choose correct answers, then schedule your weekly test.',
            ),
          SizedBox(height: 24.h),
          QuizActionButton.primary(
            label: isEdit ? 'Save Changes' : 'Continue to Questions',
            onTap: isEdit ? () {} : _continueToQuestions,
          ),
          SizedBox(height: 12.h),
          QuizActionButton.light(label: 'Save as Draft', onTap: () {}),
        ],
      ),
    );
  }
}