import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../viewmodels/learner_profile_state.dart';
import '../widgets/profile_components.dart';

class LearningPreferencesView extends StatelessWidget {
  const LearningPreferencesView({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
    builder: (context, state) {
      final p = state.profile; final c = context.read<LearnerProfileCubit>();
      return ProfilePage(title: 'Learning Preferences', child: ProfileBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('A learning routine that fits your life. Make your learning experience better.', style: TextStyle(fontSize: 11, color: ProfileColors.muted, height: 1.5)),
        const SizedBox(height: 20),
        const SectionTitle('English level'),
        const SizedBox(height: 8),
        _dropdown(p.language, ['Beginner', 'Intermediate', 'Advanced', 'English'], c.updateLanguage),
        const SizedBox(height: 18),
        const SectionTitle('Main learning goal'),
        const SizedBox(height: 8),
        _dropdown(p.studyGoal, ['Improve my skills', 'Prepare for exams', 'Career development'], c.updateStudyGoal),
        const SizedBox(height: 18),
        const SectionTitle('Daily practice goal'),
        const SizedBox(height: 8),
        Row(children: ['15 min', '30 min', '60 min'].map((v) => Expanded(child: Padding(
          padding: const EdgeInsets.only(right: 7), child: ChoiceChip(label: SizedBox(width: double.infinity, child: Text(v, textAlign: TextAlign.center)),
            selected: p.dailyGoal == v, onSelected: (_) => c.updateDailyGoal(v),
            selectedColor: ProfileColors.primaryLight, labelStyle: TextStyle(fontSize: 10, color: p.dailyGoal == v ? ProfileColors.primary : ProfileColors.ink)),
        ))).toList()),
        const SizedBox(height: 20),
        const SectionTitle('Topics you enjoy'),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: ['Technology', 'Business', 'Science', 'Travel', 'Health', 'Culture'].map((v) =>
          FilterChip(label: Text(v, style: const TextStyle(fontSize: 10)), selected: p.topics.contains(v),
            onSelected: (_) => c.toggleTopic(v), selectedColor: ProfileColors.primaryLight,
            checkmarkColor: ProfileColors.primary)).toList()),
        const SizedBox(height: 24),
        PrimaryButton(label: 'Save Preferences', onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preferences saved')))),
      ])));
    },
  );

  static Widget _dropdown(String value, List<String> options, ValueChanged<String> onChanged) => DropdownButtonFormField<String>(
    value: options.contains(value) ? value : options.first, items: options.map((v) => DropdownMenuItem(value: v, child: Text(v, style: const TextStyle(fontSize: 11)))).toList(),
    onChanged: (v) { if (v != null) onChanged(v); }, decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: const BorderSide(color: ProfileColors.line))),
  );
}
