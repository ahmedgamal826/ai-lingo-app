import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../models/quiz_models.dart';
import '../viewmodels/quizzes_cubit.dart';
import '../widgets/quiz_action_button.dart';
import '../widgets/quiz_answer_option.dart';
import '../widgets/quiz_chip.dart';
import '../widgets/quiz_confirm_dialog.dart';
import '../widgets/quiz_dropdown.dart';
import '../widgets/quiz_scaffold.dart';
import '../widgets/quiz_svg_icon.dart';
import '../widgets/quiz_text_field.dart';
import 'quiz_schedule_view.dart';

/// Preview question / Edit question: one screen, two modes.
///
/// `QuizQuestionView.preview(...)` shows the quiz's questions read-only,
/// `QuizQuestionView.edit(...)` lets the admin change, add and delete them.
class QuizQuestionView extends StatefulWidget {
  const QuizQuestionView.preview({
    super.key,
    required this.quizId,
    required this.week,
    required this.title,
    this.initialIndex = 0,
  }) : isEdit = false,
        startNew = false;

  const QuizQuestionView.edit({
    super.key,
    required this.quizId,
    required this.week,
    required this.title,
    this.initialIndex = 0,
    this.startNew = false,
  }) : isEdit = true;

  final String quizId;

  /// e.g. "Week 47"
  final String week;

  /// e.g. "Travel with Confidence"
  final String title;
  final bool isEdit;

  /// Which question to open first (0-based).
  final int initialIndex;

  /// Open directly on a blank new question (edit mode only).
  final bool startNew;

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

  static const int _defaultPoints = 5;

  final TextEditingController _question = TextEditingController();
  final TextEditingController _points = TextEditingController();
  final List<TextEditingController> _options = List.generate(
    4,
        (_) => TextEditingController(),
  );

  List<QuizQuestion> _questions = const [];
  int _index = 0;
  String _category = _categories.first;
  int _correct = -1; // -1 = no correct answer selected yet
  bool _loading = true;
  bool _busy = false;

  /// True when the screen shows a blank, not-yet-saved question.
  bool get _isNew => _index >= _questions.length;

  int get _total => _isNew ? _questions.length + 1 : _questions.length;

  QuizzesCubit get _cubit => context.read<QuizzesCubit>();

  @override
  void initState() {
    super.initState();
    _load(index: widget.initialIndex, startNew: widget.startNew);
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

  // ---------------------------------------------------------------- data

  Future<void> _load({int? index, bool startNew = false}) async {
    final cubit = _cubit;
    try {
      final questions = await cubit.getQuestions(widget.quizId);
      if (!mounted) return;
      setState(() {
        _questions = questions;
        if (startNew || (widget.isEdit && questions.isEmpty)) {
          _index = questions.length;
        } else {
          final last = questions.isEmpty ? 0 : questions.length - 1;
          final target = index ?? 0;
          _index = target > last ? last : (target < 0 ? 0 : target);
        }
        _fillForm();
        _loading = false;
        _busy = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _busy = false;
      });
      _toast('Could not load the questions.');
    }
  }

  void _fillForm() {
    if (_isNew) {
      _question.text = '';
      _points.text = '$_defaultPoints';
      _category = _categories.first;
      _correct = -1;
      for (final controller in _options) {
        controller.clear();
      }
      return;
    }
    final q = _questions[_index];
    _question.text = q.text;
    _points.text = '${q.points}';
    _category = _categories.contains(q.category)
        ? q.category
        : _categories.first;
    _correct = q.correctIndex;
    for (var i = 0; i < _options.length; i++) {
      _options[i].text = i < q.options.length ? q.options[i] : '';
    }
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String? _validate() {
    if (_question.text.trim().isEmpty) return 'Enter the question text.';
    if (_options.any((c) => c.text.trim().isEmpty)) {
      return 'Fill in all four answer options.';
    }
    if (_correct < 0) return 'Select the correct answer.';
    final points = int.tryParse(_points.text.trim());
    if (points == null || points <= 0) {
      return 'Points must be a positive number.';
    }
    return null;
  }

  bool get _hasContent =>
      _question.text.trim().isNotEmpty ||
          _options.any((c) => c.text.trim().isNotEmpty);

  /// Validates and saves the question on screen. Returns false on failure.
  Future<bool> _persist() async {
    final error = _validate();
    if (error != null) {
      _toast(error);
      return false;
    }
    final cubit = _cubit;
    final existing = _isNew ? null : _questions[_index];
    final draft = QuizQuestion(
      id: existing?.id ?? '',
      number: _index + 1,
      total: _total,
      category: _category,
      points: int.parse(_points.text.trim()),
      text: _question.text.trim(),
      options: [for (final c in _options) c.text.trim()],
      correctIndex: _correct,
    );
    try {
      await cubit.saveQuestion(widget.quizId, draft);
      return true;
    } catch (_) {
      if (mounted) _toast('Could not save the question.');
      return false;
    }
  }

  // ------------------------------------------------------------- actions

  /// Save Question: saves, then moves to the next question, or goes back
  /// when it was the last one.
  Future<void> _save() async {
    if (_busy) return;
    setState(() => _busy = true);

    final nextIndex = _index + 1;
    final hasNext = nextIndex < _questions.length;

    final ok = await _persist();
    if (!mounted) return;
    if (!ok) {
      setState(() => _busy = false);
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Question saved')));

    if (hasNext) {
      await _load(index: nextIndex);
    } else {
      Navigator.of(context).pop();
    }
  }

  /// "+ Add Question": saves the current question (if it has content),
  /// then opens a blank one at the end.
  Future<void> _addQuestion() async {
    if (_busy) return;
    if (_isNew && !_hasContent) return; // already on a blank question
    setState(() => _busy = true);

    final ok = await _persist();
    if (!mounted) return;
    if (!ok) {
      setState(() => _busy = false);
      return;
    }
    await _load(startNew: true);
  }

  Future<void> _delete() async {
    if (_busy) return;

    // A blank question was never saved: just discard it.
    if (_isNew) {
      if (_questions.isEmpty) {
        Navigator.of(context).maybePop();
      } else {
        setState(() {
          _index = _questions.length - 1;
          _fillForm();
        });
      }
      return;
    }

    final confirmed = await showQuizConfirmDialog(
      context,
      title: 'Delete question?',
      message:
      'Question ${_index + 1} will be permanently removed and the remaining questions will be renumbered. This can\'t be undone.',
      confirmLabel: 'Delete',
    );
    if (!confirmed || !mounted) return;

    setState(() => _busy = true);
    final cubit = _cubit;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final questionId = _questions[_index].id;

    try {
      await cubit.deleteQuestion(widget.quizId, questionId);
      messenger.showSnackBar(
        const SnackBar(content: Text('Question deleted')),
      );
      final remaining = await cubit.getQuestions(widget.quizId);
      if (!mounted) return;
      if (remaining.isEmpty) {
        navigator.pop();
        return;
      }
      setState(() {
        _questions = remaining;
        if (_index >= remaining.length) _index = remaining.length - 1;
        _fillForm();
        _busy = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _busy = false);
      _toast('Could not delete the question.');
    }
  }

  void _previous() {
    if (_index > 0) {
      setState(() {
        _index -= 1;
        _fillForm();
      });
    } else {
      Navigator.of(context).maybePop();
    }
  }

  void _next() {
    if (_index < _questions.length - 1) {
      setState(() {
        _index += 1;
        _fillForm();
      });
    } else {
      _openSchedule();
    }
  }

  Future<void> _openEdit({bool startNew = false}) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => QuizQuestionView.edit(
          quizId: widget.quizId,
          week: widget.week,
          title: widget.title,
          initialIndex: _index,
          startNew: startNew,
        ),
      ),
    );
    if (mounted) await _load(index: _index);
  }

  void _openSchedule() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            QuizScheduleView(week: widget.week, title: widget.title),
      ),
    );
  }

  // --------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.isEdit;
    final title = isEdit ? 'Edit Question' : 'Preview Question';
    final subtitle =
        '${widget.week.toUpperCase()} · ${widget.title.toUpperCase()}';

    if (_loading) {
      return QuizScaffold(
        title: title,
        subtitle: subtitle,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Preview of a quiz that has no questions yet.
    if (!isEdit && _questions.isEmpty) {
      return QuizScaffold(
        title: title,
        subtitle: subtitle,
        body: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 32.h, 20.w, 24.h),
          children: [
            Text(
              'No questions yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Add the first question to continue building this quiz.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary),
            ),
            SizedBox(height: 24.h),
            QuizActionButton.primary(
              label: 'Add Question',
              iconName: 'plus',
              onTap: () => _openEdit(startNew: true),
            ),
            SizedBox(height: 12.h),
            QuizActionButton.light(
              label: 'Previous',
              onTap: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      );
    }

    return QuizScaffold(
      title: title,
      subtitle: subtitle,
      trailing: IconButton(
        onPressed: isEdit ? _delete : () => _openEdit(),
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
                'QUESTION ${_index + 1} OF $_total',
                letterSpacing: 0.5,
              ),
              if (isEdit)
                InkWell(
                  onTap: _addQuestion,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 6.h,
                    ),
                    child: Text(
                      '+ Add Question',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
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
                    if (_correct >= 0) ...[
                      Icon(Icons.check, size: 10.w, color: AppColors.success),
                      SizedBox(width: 4.w),
                    ],
                    Text(
                      _correct >= 0
                          ? 'Option ${String.fromCharCode(65 + _correct)} is the correct answer'
                          : 'Select the correct answer',
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: _correct >= 0
                            ? AppColors.success
                            : AppColors.textSecondary,
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
                  onTap: _previous,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: QuizActionButton.primary(
                  label: isEdit ? 'Save Question' : 'Next',
                  onTap: isEdit ? _save : _next,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}