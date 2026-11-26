import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../viewmodels/learner_profile_state.dart';
import '../widgets/profile_components.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';

class LearningPreferencesView extends StatelessWidget {
  const LearningPreferencesView({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
    builder: (context, state) {
      final p = state.profile;
      final cubit = context.read<LearnerProfileCubit>();
      return ProfilePage(
        title: 'Learning Preferences',
        child: ProfileBody(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'A learning routine that fits your life. Make your learning experience better.',
                style: TextStyle(fontSize: AppFontSizes.font10, height: 1.45, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 13),
              const SectionTitle('English level'),
              const SizedBox(height: 7),
              ProfileDropdown(value: p.language, options: const ['Beginner', 'Intermediate', 'Advanced', 'English'], onChanged: cubit.updateLanguage),
              const SizedBox(height: AppDimensions.spaceMd),
              const SectionTitle('Main learning goal'),
              const SizedBox(height: 7),
              ProfileDropdown(value: p.studyGoal, options: const ['Improve my skills', 'Prepare for exams', 'Career development'], onChanged: cubit.updateStudyGoal),
              const SizedBox(height: AppDimensions.spaceMd),
              const SectionTitle('Daily practice goal'),
              const SizedBox(height: AppDimensions.spaceSm),
              Row(
                children: ['15 min', '30 min', '60 min'].map((value) {
                  final selected = p.dailyGoal == value;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(9),
                        onTap: () => cubit.updateDailyGoal(value),
                        child: Container(
                          height: 38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected ? AppColors.primaryLight : AppColors.white,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: selected ? AppColors.primary : AppColors.indicatorInactive),
                          ),
                          child: Text(value, style: TextStyle(fontSize: AppFontSizes.font10, fontWeight: FontWeight.w600,
                            color: selected ? AppColors.primary : AppColors.textPrimary)),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppDimensions.spaceMd),
              const SectionTitle('Daily reminder'),
              const SizedBox(height: 7),
              ProfileCard(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(children: [
                  Row(children: [
                    Container(width: 30, height: 30, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)), child: const Center(child: SvgAssetIcon('bell', size: 15, color: AppColors.primary))),
                    const SizedBox(width: 9),
                    const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Daily practice reminder', style: TextStyle(fontSize: AppFontSizes.font10, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      Text('Get a friendly reminder to keep your learning streak.', style: TextStyle(fontSize: AppFontSizes.font9, color: AppColors.textSecondary)),
                    ])),
                    Transform.scale(scale: .78, child: Switch(value: p.dailyReminderEnabled, onChanged: cubit.toggleDailyReminder, activeColor: AppColors.primary, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
                  ]),
                  if (p.dailyReminderEnabled) ...[
                    const Divider(height: 16, color: AppColors.indicatorInactive),
                    Row(children: [const Expanded(child: Text('Reminder time', style: TextStyle(fontSize: AppFontSizes.font9, color: AppColors.textSecondary))), SizedBox(width: 112, child: ProfileDropdown(value: p.dailyReminderTime, options: const ['07:00 AM', '08:00 AM', '09:00 AM', '06:00 PM', '08:00 PM'], onChanged: cubit.updateDailyReminderTime, fontSize: AppFontSizes.font9))]),
                  ],
                ]),
              ),
              const SizedBox(height: AppDimensions.spaceMd),
              const SectionTitle('Topics you enjoy'),
              const SizedBox(height: 7),
              Wrap(
                spacing: 6,
                runSpacing: 2,
                children: ['Technology', 'Business', 'Science', 'Travel', 'Health', 'Culture'].map((value) =>
                  FilterChip(
                    label: Text(value, style: const TextStyle(fontSize: AppFontSizes.font9)),
                    selected: p.topics.contains(value),
                    onSelected: (_) => cubit.toggleTopic(value),
                    selectedColor: AppColors.primaryLight,
                    backgroundColor: AppColors.white,
                    checkmarkColor: AppColors.primary,
                    side: BorderSide(color: p.topics.contains(value) ? AppColors.primary : AppColors.indicatorInactive),
                    visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ).toList(),
              ),
              const SizedBox(height: AppDimensions.spaceMd),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: AppColors.primarySoft),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: SvgAssetIcon('sparkles', size: 15, color: AppColors.primary),
                    ),
                    const SizedBox(width: AppDimensions.spaceSm),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                        Text('Your AI adapts with you', style: TextStyle(fontSize: AppFontSizes.font10, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        SizedBox(height: 3),
                        Text('We use your preferences to personalize your learning journey and recommend content that matches your goals.',
                          style: TextStyle(fontSize: AppFontSizes.font9, height: 1.4, color: AppColors.textSecondary)),
                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 17),
              PrimaryButton(
                label: 'Save Preferences',
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Preferences saved')),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

}
