import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/quiz_models.dart';
import '../viewmodels/quizzes_cubit.dart';
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
  late String _level;

  /// Set after the first save in create mode, so tapping "Continue" twice
  /// updates the same quiz instead of creating a duplicate.
  Quiz? _created;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    final quiz = widget.quiz;
    _title = TextEditingController(text: quiz?.title ?? '');
    _description = TextEditingController(text: quiz?.description ?? '');
    _week = TextEditingController(
      text: quiz == null ? _nextWeek() : quiz.week.replaceFirst('Week ', ''),
    );
    _duration = TextEditingController(text: '${quiz?.durationMinutes ?? 20}');
    _attempts = TextEditingController(text: '${quiz?.attempts ?? 1}');
    _level = _levels.contains(quiz?.level) ? quiz!.level : 'B1';
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

  /// The week after the latest existing quiz.
  String _nextWeek() {
    var max = 0;
    for (final quiz in context.read<QuizzesCubit>().state.quizzes) {
      final n = int.tryParse(quiz.week.replaceFirst('Week ', ''));
      if (n != null && n > max) max = n;
    }
    return '${max + 1}';
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Quiz? _fail(String message) {
    _toast(message);
    return null;
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

  /// Validates the form and builds the quiz. Returns null (and shows a
  /// message) when something is wrong.
  Quiz? _readForm() {
    final title = _title.text.trim();
    final description = _description.text.trim();
    final week = int.tryParse(_week.text.trim());
    final duration = int.tryParse(_duration.text.trim());
    final attempts = int.tryParse(_attempts.text.trim());

    if (title.isEmpty) return _fail('Enter the quiz title.');
    if (week == null) return _fail('Choose the week.');
    if (duration == null || duration <= 0) {
      return _fail('Duration must be a positive number.');
    }
    if (attempts == null || attempts <= 0) {
      return _fail('Allowed attempts must be a positive number.');
    }

    final base = widget.quiz ?? _created;
    if (base != null) {
      return base.copyWith(
        week: 'Week $week',
        title: title,
        description: description,
        level: _level,
        durationMinutes: duration,
        attempts: attempts,
      );
    }
    return Quiz(
      week: 'Week $week',
      title: title,
      status: QuizStatus.draft,
      schedule: 'No schedule set',
      summary: '',
      description: description,
      level: _level,
      durationMinutes: duration,
      attempts: attempts,
    );
  }

  /// Creates the quiz (as a draft) or updates it. Returns null on failure.
  Future<Quiz?> _persist() async {
    final form = _readForm();
    if (form == null) return null;
    final cubit = context.read<QuizzesCubit>();
    try {
      if (form.id.isEmpty) {
        _created = await cubit.createQuiz(form);
        return _created;
      }
      await cubit.updateQuiz(form);
      return form;
    } catch (_) {
      if (mounted) _toast('Could not save the quiz. Please try again.');
      return null;
    }
  }

  Future<void> _continueToQuestions() async {
    if (_busy) return;
    setState(() => _busy = true);
    final quiz = await _persist();
    if (!mounted) return;
    setState(() => _busy = false);
    if (quiz == null) return;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => QuizQuestionView.preview(
          quizId: quiz.id,
          week: quiz.week,
          title: quiz.title,
        ),
      ),
    );
  }

  Future<void> _saveChanges() async {
    if (_busy) return;
    setState(() => _busy = true);
    final quiz = await _persist();
    if (!mounted) return;
    setState(() => _busy = false);
    if (quiz == null) return;

    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(const SnackBar(content: Text('Changes saved')));
  }

  Future<void> _saveAsDraft() async {
    if (_busy) return;
    setState(() => _busy = true);
    final quiz = await _persist();
    if (!mounted) return;
    setState(() => _busy = false);
    if (quiz == null) return;

    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(const SnackBar(content: Text('Draft saved')));
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
          QuizTextField(
            label: 'Quiz title',
            controller: _title,
            hint: 'e.g. Travel with Confidence',
          ),
          SizedBox(height: 16.h),
          QuizTextField(
            label: 'Description',
            controller: _description,
            hint: 'What will learners practice in this quiz?',
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
            QuizInfoBox(
              iconName: 'shield-check',
              title: 'Edit with care',
              message: widget.quiz!.submissions > 0
                  ? 'This test has ${widget.quiz!.submissions} submissions. Changes are recorded in the activity log.'
                  : 'Changes are recorded in the activity log.',
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
            onTap: isEdit ? _saveChanges : _continueToQuestions,
          ),
          if (!isEdit) ...[
            SizedBox(height: 12.h),
            QuizActionButton.light(label: 'Save as Draft', onTap: _saveAsDraft),
          ],
        ],
      ),
    );
  }
}