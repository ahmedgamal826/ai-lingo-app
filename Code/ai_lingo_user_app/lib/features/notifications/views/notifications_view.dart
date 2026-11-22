// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../core/constants/app_assets.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_dimensions.dart';
// import '../../../core/widgets/custom_bottom_nav_bar.dart';
// import '../../../core/widgets/custom_card.dart';
// import '../../../core/widgets/custom_text.dart';
// import 'broadcast_announcement_view.dart';
//
// class NotificationsView extends StatefulWidget {
//   const NotificationsView({super.key});
//
//   @override
//   State<NotificationsView> createState() => _NotificationsViewState();
// }
//
// class _NotificationsViewState extends State<NotificationsView> {
//   int _selectedFilter = 0;
//   int _selectedNav = 3;
//   final List<_NotificationData> _notifications = [
//     _NotificationData(
//       title: 'New complaint from Alex Carter',
//       category: '#C-1042 · Quiz & scoring',
//       description:
//           "Weekly test score looks incorrect. Review the learner's question 8 result.",
//       date: 'Nov 15 · 8:12 PM',
//       icon: 'message-square-warning.svg',
//       unread: true,
//       type: 'Unread',
//     ),
//     _NotificationData(
//       title: '48 new learners this week',
//       category: 'User activity · Weekly summary',
//       description:
//           '1,248 learners are now part of AI-Lingo. 846 have been active this week.',
//       date: 'Nov 16 · 8:00 AM',
//       icon: 'users-round.svg',
//       unread: true,
//       type: 'Unread',
//     ),
//     _NotificationData(
//       title: 'Scheduled maintenance',
//       category: 'System alert · Important',
//       description:
//           'Audio services will be updated Nov 18, 2:00–2:15 AM UTC.',
//       date: 'Nov 16 · 7:30 AM',
//       icon: 'shield-alert.svg',
//       unread: true,
//       type: 'Important',
//     ),
//     _NotificationData(
//       title: 'Week 46 test has closed',
//       category: 'Everyday English · 182 submissions',
//       description:
//           'Results are ready for review. The average score is 78%.',
//       date: 'Nov 15 · 8:00 PM',
//       icon: 'clipboard-check.svg',
//       unread: false,
//       type: 'Read',
//     ),
//   ];
//
//   int get _unreadCount => _notifications.where((n) => n.unread).length;
//
//   @override
//   Widget build(BuildContext context) {
//     final visible = _selectedFilter == 1
//         ? _notifications.where((n) => n.unread).toList()
//         : _notifications;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FC),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
//                 children: [
//                   _buildFilter(),
//                   SizedBox(height: 14.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CustomText(
//                         text: 'Your admin inbox',
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.textPrimary,
//                       ),
//                       GestureDetector(
//                         onTap: () => setState(() {
//                           for (final item in _notifications) {
//                             item.unread = false;
//                           }
//                         }),
//                         child: CustomText(
//                           text: 'Mark all read',
//                           fontSize: 11.sp,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12.h),
//                   for (final item in visible) ...[
//                     _NotificationCard(
//                       data: item,
//                       onTap: () => setState(() => item.unread = false),
//                     ),
//                     SizedBox(height: 12.h),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: _selectedNav,
//         onTap: (index) => setState(() => _selectedNav = index),
//         items: const [
//           BottomNavItem(label: 'Dashboard', icon: Icons.dashboard_outlined, iconAsset: 'assets/icons/layout-dashboard.svg'),
//           BottomNavItem(label: 'Quizzes', icon: Icons.assignment_outlined, iconAsset: 'assets/icons/clipboard-list.svg'),
//           BottomNavItem(label: 'Complaints', icon: Icons.forum_outlined, iconAsset: 'assets/icons/messages-square.svg'),
//           BottomNavItem(label: 'Notifications', icon: Icons.notifications_none, iconAsset: 'assets/icons/bell.svg'),
//           BottomNavItem(label: 'Profile', icon: Icons.person_outline, iconAsset: 'assets/icons/user-round.svg'),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       height: 68.h,
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       color: AppColors.white,
//       child: Row(
//         children: [
//           CustomText(
//             text: 'Notifications',
//             fontSize: 21.sp,
//             fontWeight: FontWeight.w700,
//             color: AppColors.textPrimary,
//           ),
//           const Spacer(),
//           GestureDetector(
//             onTap: () => Navigator.of(context).push(
//               MaterialPageRoute<void>(
//                 builder: (_) => const BroadcastAnnouncementView(),
//               ),
//             ),
//             child: SvgPicture.asset(
//               AppAssets.icon('plus.svg'),
//               width: 20.w,
//               height: 20.w,
//               colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFilter() {
//     return Container(
//       height: 40.h,
//       padding: EdgeInsets.all(3.w),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE9EBF3),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Row(
//         children: [
//           _filterOption('All', 0),
//           _filterOption('Unread · $_unreadCount', 1),
//         ],
//       ),
//     );
//   }
//
//   Widget _filterOption(String label, int index) {
//     final selected = _selectedFilter == index;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => setState(() => _selectedFilter = index),
//         child: Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: selected ? AppColors.white : Colors.transparent,
//             borderRadius: BorderRadius.circular(9.r),
//           ),
//           child: CustomText(
//             text: label,
//             fontSize: 12.sp,
//             fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
//             color: selected ? AppColors.primary : AppColors.textSecondary,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _NotificationData {
//   _NotificationData({
//     required this.title,
//     required this.category,
//     required this.description,
//     required this.date,
//     required this.icon,
//     required this.unread,
//     required this.type,
//   });
//
//   final String title;
//   final String category;
//   final String description;
//   final String date;
//   final String icon;
//   bool unread;
//   final String type;
// }
//
// class _NotificationCard extends StatelessWidget {
//   const _NotificationCard({required this.data, required this.onTap});
//
//   final _NotificationData data;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     final tinted = data.unread;
//     return CustomCard(
//       onTap: onTap,
//       elevation: 0,
//       padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 10.h),
//       backgroundColor: tinted ? const Color(0xFFEEF0FF) : AppColors.white,
//       borderRadius: BorderRadius.circular(15.r),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SvgPicture.asset(
//             AppAssets.icon(data.icon),
//             width: 17.w,
//             height: 17.w,
//             colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
//           ),
//           SizedBox(width: 9.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomText(
//                   text: data.title,
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textPrimary,
//                 ),
//                 SizedBox(height: 3.h),
//                 CustomText(
//                   text: data.category,
//                   fontSize: 10.sp,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.primary,
//                 ),
//                 SizedBox(height: 5.h),
//                 CustomText(
//                   text: data.description,
//                   fontSize: 10.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.textSecondary,
//                   maxLines: 2,
//                 ),
//                 SizedBox(height: 5.h),
//                 CustomText(
//                   text: '${data.date} · ${data.unread ? 'Unread' : data.type == 'Important' ? 'Important' : 'Read'}',
//                   fontSize: 9.sp,
//                   color: AppColors.textSecondary,
//                 ),
//               ],
//             ),
//           ),
//           if (data.unread)
//             Container(
//               width: 6.w,
//               height: 6.w,
//               margin: EdgeInsets.only(top: 2.h, left: 5.w),
//               decoration: const BoxDecoration(
//                 color: AppColors.primary,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
