import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_font_sizes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../viewmodels/learner_profile_state.dart';

/// Learner notifications — typography & layout matched to Figma node 6:78635.
class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  /// 0 = All, 1 = Unread
  int _selectedFilter = 0;

  late final List<_NotificationItem> _items = [
    _NotificationItem(
      iconAsset: 'megaphone',
      title: 'Practice more. Grow together.',
      body:
          'Join the Week 46 English challenge. Your next conversation starts with confidence.',
      meta: 'Announcement · Nov 12, 9:00 AM',
      unread: true,
      important: true,
    ),
    _NotificationItem(
      iconAsset: 'message-square-check',
      title: 'Jamie replied to your request',
      body: 'Request #C-1042 is resolved. Your test score is now 90/100.',
      meta: 'Support · Nov 16, 9:05 AM',
      unread: true,
    ),
    _NotificationItem(
      iconAsset: 'trophy',
      title: 'Your Week 46 results are ready',
      body: 'You scored 90/100 and earned 100 points. You’re now #12!',
      meta: 'Quiz results · Nov 16, 9:05 AM',
      unread: true,
    ),
    _NotificationItem(
      iconAsset: 'clipboard-check',
      title: 'Your weekly test is open',
      body: 'Everyday English is live until Nov 15 at 8:00 PM.',
      meta: 'Weekly test · Nov 13, 9:00 AM',
      unread: false,
    ),
    _NotificationItem(
      iconAsset: 'sparkles',
      title: 'A smoother learning experience',
      body: 'We’ve improved conversation audio and word pronunciation.',
      meta: 'App update · Nov 10, 2:00 PM',
      unread: false,
    ),
  ];

  void _markItemRead(_NotificationItem item) {
    if (!item.unread) return;
    setState(() => item.unread = false);
    if (_items.every((n) => !n.unread)) {
      context.read<LearnerProfileCubit>().markNotificationsRead();
    }
  }

  void _markAllRead() {
    setState(() {
      for (final item in _items) {
        item.unread = false;
      }
    });
    context.read<LearnerProfileCubit>().markNotificationsRead();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
      builder: (context, state) {
        final allRead = state.notificationsRead;
        bool isUnread(_NotificationItem item) => !allRead && item.unread;
        final visible = _items.where((item) {
          if (_selectedFilter == 1) return isUnread(item);
          return true;
        }).toList();
        final unreadCount = _items.where(isUnread).length;

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FC),
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            centerTitle: false,
            toolbarHeight: 56.h,
            leadingWidth: 48.w,
            leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: SvgPicture.asset(
                AppAssets.arrowLeft,
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            titleSpacing: 0,
            title: Text(
              'Notifications',
              style: TextStyle(
                fontFamily: AppTextStyles.fontFamily,
                fontSize: AppFontSizes.font18.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
                letterSpacing: 0,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
            children: [
              _SegmentedTabs(
                selectedIndex: _selectedFilter,
                unreadCount: unreadCount,
                onChanged: (index) => setState(() => _selectedFilter = index),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Your learning, in the loop',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppFontSizes.font16.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        letterSpacing: 0,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: unreadCount == 0 ? null : _markAllRead,
                    child: Text(
                      'Mark all read',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppFontSizes.font11.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        letterSpacing: 0,
                        color: unreadCount == 0
                            ? AppColors.textSecondary
                            : AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              if (visible.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 48.h),
                  child: Text(
                    'No notifications here yet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: AppFontSizes.font12.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      color: AppColors.textSecondary,
                    ),
                  ),
                )
              else
                ...visible.map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: _NotificationCard(
                      item: item,
                      isUnread: isUnread(item),
                      onTap: () => _markItemRead(item),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  const _SegmentedTabs({
    required this.selectedIndex,
    required this.unreadCount,
    required this.onChanged,
  });

  final int selectedIndex;
  final int unreadCount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.indicatorInactive,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabChip(
              label: 'All',
              selected: selectedIndex == 0,
              onTap: () => onChanged(0),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: _TabChip(
              label: 'Unread · $unreadCount',
              selected: selectedIndex == 1,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.white : Colors.transparent,
      elevation: selected ? 1 : 0,
      shadowColor: const Color(0x1A20243D),
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: AppTextStyles.fontFamily,
              fontSize: AppFontSizes.font12.sp,
              fontWeight: FontWeight.w600,
              height: 1.0,
              letterSpacing: 0,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.item,
    required this.isUnread,
    required this.onTap,
  });

  final _NotificationItem item;
  final bool isUnread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isUnread ? AppColors.primaryLight : AppColors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: isUnread ? onTap : null,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34.w,
                height: 34.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: SvgPicture.asset(
                  AppAssets.icon('${item.iconAsset}.svg'),
                  width: 18.w,
                  height: 18.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              fontSize: AppFontSizes.font12.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                              letterSpacing: 0,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (isUnread) ...[
                          SizedBox(width: 5.w),
                          Container(
                            width: 6.w,
                            height: 6.w,
                            margin: EdgeInsets.only(top: 5.h),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      item.body,
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppFontSizes.font11.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                        letterSpacing: 0,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      item.meta,
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: AppFontSizes.font9.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                        letterSpacing: 0,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (item.important) ...[
                      SizedBox(height: 5.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 9.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.purpleLight,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Important',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: AppFontSizes.font10.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                            letterSpacing: 0,
                            color: AppColors.purple,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationItem {
  _NotificationItem({
    required this.iconAsset,
    required this.title,
    required this.body,
    required this.meta,
    required this.unread,
    this.important = false,
  });

  final String iconAsset;
  final String title;
  final String body;
  final String meta;
  bool unread;
  final bool important;
}
