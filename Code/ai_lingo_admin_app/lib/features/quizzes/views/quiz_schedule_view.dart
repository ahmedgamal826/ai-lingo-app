import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../widgets/quiz_action_button.dart';
import '../widgets/quiz_chip.dart';
import '../widgets/quiz_dropdown.dart';
import '../widgets/quiz_info_box.dart';
import '../widgets/quiz_picker_field.dart';
import '../widgets/quiz_scaffold.dart';
import '../widgets/quiz_summary_card.dart';
import 'quiz_published_view.dart';

/// Schedule Weekly Test: pick when the test opens and closes, then publish.
class QuizScheduleView extends StatefulWidget {
  const QuizScheduleView({super.key, required this.week, required this.title});

  /// e.g. "Week 47"
  final String week;

  /// e.g. "Travel with Confidence"
  final String title;

  @override
  State<QuizScheduleView> createState() => _QuizScheduleViewState();
}

class _QuizScheduleViewState extends State<QuizScheduleView> {
  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static const List<String> _zones = ['UTC · Coordinated Universal Time'];

  // Temporary sample values (match Figma). The Cubit will provide real data.
  DateTime _opens = DateTime(2026, 11, 20, 9, 0);
  DateTime _closes = DateTime(2026, 11, 22, 20, 0);
  String _zone = _zones.first;

  static String _date(DateTime d) =>
      '${_months[d.month - 1]} ${d.day}, ${d.year}';

  static String _shortDate(DateTime d) => '${_months[d.month - 1]} ${d.day}';

  static String _time(DateTime d) {
    final t = TimeOfDay.fromDateTime(d);
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<DateTime?> _pickDate(DateTime current) {
    return showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2025),
      lastDate: DateTime(2035),
    );
  }

  Future<TimeOfDay?> _pickTime(DateTime current) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current),
    );
  }

  DateTime _withDate(DateTime base, DateTime date) =>
      DateTime(date.year, date.month, date.day, base.hour, base.minute);

  DateTime _withTime(DateTime base, TimeOfDay time) =>
      DateTime(base.year, base.month, base.day, time.hour, time.minute);

  Future<void> _changeOpensDate() async {
    final picked = await _pickDate(_opens);
    if (picked != null) setState(() => _opens = _withDate(_opens, picked));
  }

  Future<void> _changeOpensTime() async {
    final picked = await _pickTime(_opens);
    if (picked != null) setState(() => _opens = _withTime(_opens, picked));
  }

  Future<void> _changeClosesDate() async {
    final picked = await _pickDate(_closes);
    if (picked != null) setState(() => _closes = _withDate(_closes, picked));
  }

  Future<void> _changeClosesTime() async {
    final picked = await _pickTime(_closes);
    if (picked != null) setState(() => _closes = _withTime(_closes, picked));
  }

  void _publish() {
    if (!_closes.isAfter(_opens)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Closing time must be after opening time.'),
        ),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => QuizPublishedView(
          week: widget.week,
          title: widget.title,
          opensText: '${_shortDate(_opens)} at ${_time(_opens)}',
          closesText: '${_shortDate(_closes)} at ${_time(_closes)}',
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _dateTimeRow({
    required DateTime value,
    required VoidCallback onDateTap,
    required VoidCallback onTimeTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: QuizPickerField(
            label: 'Date',
            value: _date(value),
            iconName: 'calendar',
            onTap: onDateTap,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: QuizPickerField(
            label: 'Time',
            value: _time(value),
            iconName: 'clock',
            onTap: onTimeTap,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuizScaffold(
      title: 'Schedule Weekly Test',
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: QuizChip('STEP 3 OF 3 · SCHEDULE', letterSpacing: 0.5),
          ),
          SizedBox(height: 16.h),
          QuizSummaryCard(
            title: widget.title,
            details: '${widget.week} · B1 · 20 questions · 20 minutes',
            note: 'All questions have a correct answer',
          ),
          SizedBox(height: 20.h),
          _sectionTitle('Test opens'),
          _dateTimeRow(
            value: _opens,
            onDateTap: _changeOpensDate,
            onTimeTap: _changeOpensTime,
          ),
          SizedBox(height: 20.h),
          _sectionTitle('Test closes'),
          _dateTimeRow(
            value: _closes,
            onDateTap: _changeClosesDate,
            onTimeTap: _changeClosesTime,
          ),
          SizedBox(height: 20.h),
          QuizDropdown(
            label: 'Time zone',
            value: _zone,
            items: _zones,
            onChanged: (v) => setState(() => _zone = v ?? _zone),
          ),
          SizedBox(height: 16.h),
          const QuizInfoBox(
            iconName: 'bell',
            title: 'A timely reminder',
            message:
            'Learners will be notified when the test opens. The test locks automatically after closing.',
          ),
          SizedBox(height: 24.h),
          QuizActionButton.primary(
            label: 'Publish & Schedule Test',
            iconName: 'calendar-check',
            onTap: _publish,
          ),
        ],
      ),
    );
  }
}