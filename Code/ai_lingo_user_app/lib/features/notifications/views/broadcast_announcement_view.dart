// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../core/constants/app_assets.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_dimensions.dart';
// import '../../../core/widgets/custom_card.dart';
// import '../../../core/widgets/custom_text.dart';
// import '../../../core/widgets/custom_drop_down_menu.dart';
// import '../../../core/widgets/custom_button.dart';
//
// class BroadcastAnnouncementView extends StatefulWidget {
//   const BroadcastAnnouncementView({super.key});
//
//   @override
//   State<BroadcastAnnouncementView> createState() =>
//       _BroadcastAnnouncementViewState();
// }
//
// class _BroadcastAnnouncementViewState extends State<BroadcastAnnouncementView> {
//   final _titleController = TextEditingController(text: 'Practice more. Grow together.');
//   final _messageController = TextEditingController(
//     text: 'Join the Week 46 English challenge. Your next conversation starts with confidence.',
//   );
//   String _category = 'Announcement';
//   String _priority = 'Important';
//
//   @override
//   void dispose() {
//     _titleController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }
//
//   OutlineInputBorder _border(Color color) => OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: BorderSide(color: color, width: 1),
//       );
//
//   InputDecoration _fieldDecoration({String? hint}) => InputDecoration(
//         hintText: hint,
//         filled: true,
//         fillColor: AppColors.white,
//         contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
//         border: _border(AppColors.indicatorInactive),
//         enabledBorder: _border(AppColors.indicatorInactive),
//         focusedBorder: _border(AppColors.primary),
//       );
//
//   Widget _fieldLabel(String label) => CustomText(
//         text: label,
//         fontSize: 12.sp,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimary,
//         padding: EdgeInsets.only(bottom: 7.h),
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FC),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               height: 62.h,
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               color: AppColors.white,
//               child: Row(
//                 children: [
//                   InkWell(
//                     onTap: () => Navigator.of(context).pop(),
//                     borderRadius: BorderRadius.circular(24.r),
//                     child: Padding(
//                       padding: EdgeInsets.all(6.w),
//                       child: Icon(Icons.arrow_back, size: 20.w, color: AppColors.textPrimary),
//                     ),
//                   ),
//                   SizedBox(width: 8.w),
//                   CustomText(
//                     text: 'Broadcast Announcement',
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.textPrimary,
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
//                       decoration: BoxDecoration(
//                         color: AppColors.purpleLight,
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                       child: CustomText(
//                         text: 'REACH YOUR LEARNING COMMUNITY',
//                         fontSize: 8.5.sp,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.purple,
//                       ),
//                     ),
//                     SizedBox(height: 12.h),
//                     CustomText(
//                       text: 'A little encouragement goes\\na long way.',
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.textPrimary,
//                       maxLines: 2,
//                     ),
//                     SizedBox(height: 18.h),
//                     _fieldLabel('Title'),
//                     TextFormField(
//                       controller: _titleController,
//                       style: TextStyle(fontSize: 12.sp, color: AppColors.textPrimary),
//                       decoration: _fieldDecoration(),
//                     ),
//                     SizedBox(height: 18.h),
//                     CustomDropDownMenu<String>(
//                       items: const ['Announcement', 'Challenge', 'Update', 'Reminder'],
//                       value: _category,
//                       onChanged: (value) => setState(() => _category = value ?? _category),
//                       itemLabel: (item) => item,
//                       label: 'Category',
//                     ),
//                     SizedBox(height: 18.h),
//                     _fieldLabel('Message'),
//                     TextFormField(
//                       controller: _messageController,
//                       minLines: 3,
//                       maxLines: 4,
//                       style: TextStyle(fontSize: 12.sp, color: AppColors.textPrimary, height: 1.4),
//                       decoration: _fieldDecoration(),
//                     ),
//                     SizedBox(height: 18.h),
//                     CustomDropDownMenu<String>(
//                       items: const ['Important', 'Normal', 'Low'],
//                       value: _priority,
//                       onChanged: (value) => setState(() => _priority = value ?? _priority),
//                       itemLabel: (item) => item,
//                       label: 'Priority',
//                     ),
//                     SizedBox(height: 14.h),
//                     CustomCard(
//                       elevation: 0,
//                       padding: EdgeInsets.all(12.w),
//                       backgroundColor: AppColors.primaryLight,
//                       borderRadius: BorderRadius.circular(14.r),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SvgPicture.asset(
//                             AppAssets.icon('users-round.svg'),
//                             width: 17.w,
//                             height: 17.w,
//                             colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
//                           ),
//                           SizedBox(width: 10.w),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CustomText(
//                                   text: 'All learners · 1,248 recipients',
//                                   fontSize: 10.5.sp,
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.textPrimary,
//                                 ),
//                                 SizedBox(height: 4.h),
//                                 CustomText(
//                                   text: 'This announcement will appear in every learner’s notifications.',
//                                   fontSize: 9.sp,
//                                   color: AppColors.textSecondary,
//                                   maxLines: 2,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 24.h),
//                     SizedBox(
//                       width: double.infinity,
//                       child: CustomDarkButton(
//                         text: 'Preview Announcement',
//                      //   icon: Icons.visibility_outlined,
//                         width: double.infinity,
//                         onTap: _showPreview,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showPreview() {
//     showDialog<void>(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: AppColors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//         title: CustomText(
//           text: 'Preview Announcement',
//           fontSize: 16.sp,
//           fontWeight: FontWeight.w700,
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomText(text: _titleController.text, fontSize: 14.sp, fontWeight: FontWeight.w600),
//             SizedBox(height: 8.h),
//             CustomText(text: _messageController.text, fontSize: 12.sp, color: AppColors.textSecondary),
//             SizedBox(height: 10.h),
//             CustomText(text: '$_category · $_priority', fontSize: 10.sp, color: AppColors.primary),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
// }
