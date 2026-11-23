
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';
import '../widgets_core/custom_button.dart';
import '../widgets_core/custom_card.dart';
import '../widgets_core/custom_icon_button.dart';

/// Confirmation screen shown before removing a saved vocabulary word.
class DeleteWordConfirmationView extends StatelessWidget {
  const DeleteWordConfirmationView({
    super.key,
    required this.word,
  });

  final String word;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 64,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(
          children: [
            CustomIconButton(
              icon: Icons.arrow_back,
              color: AppColors.textPrimary,
              size: 22,
              onPressed: () => Navigator.pop(context, false),
            ),
            const SizedBox(width: 8),
            const Text(
              'Manage vocabulary',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: AppFontSizes.font16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            child: CustomCard(
              backgroundColor: AppColors.white,
              elevation: 0,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusXl,
              ),
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Delete Icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.errorLight,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppAssets.icon('delete.svg'),
                      width: 21,
                      height: 21,
                      colorFilter: const ColorFilter.mode(
                        AppColors.danger,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Title
                  const Text(
                    'Delete this word?',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppFontSizes.font16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Description
                  Text(
                    '"$word" will be removed from your saved vocabulary and '
                        'favorites. You can always add it again.',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppFontSizes.font11,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Delete Word Button
                  SizedBox(
                    width: double.infinity,
                    child: CustomRedButton(
                      text: 'Delete Word',
                      onTap: () => Navigator.pop(context, true),
                      width: double.infinity,
                      height: 44,
                      borderRadius: 12,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Keep Learning Button
                  SizedBox(
                    width: double.infinity,
                    child: CustomLightButton(
                      text: 'Keep Learning This Word',
                      onTap: () => Navigator.pop(context, false),
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
















// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../core/constants/app_assets.dart';
//
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_dimensions.dart';
// import '../../../core/theme/app_font_sizes.dart';
// import '../widgets_core/custom_button.dart';
// import '../widgets_core/custom_card.dart';
// import '../widgets_core/custom_icon_button.dart';
//
// /// Confirmation screen shown before removing a saved vocabulary word.
// class DeleteWordConfirmationView extends StatelessWidget {
//   const DeleteWordConfirmationView({
//     super.key,
//     required this.word,
//   });
//
//   final String word;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FC),
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         surfaceTintColor: Colors.transparent,
//         elevation: 0,
//         toolbarHeight: 64,
//         automaticallyImplyLeading: false,
//         titleSpacing: 16,
//         title: Row(
//           children: [
//             CustomIconButton(
//               icon: Icons.arrow_back,
//               color: AppColors.textPrimary,
//               size: 22,
//               onPressed: () => Navigator.pop(context, false),
//             ),
//             const SizedBox(width: 8),
//             const Text(
//               'Manage vocabulary',
//               style: TextStyle(
//                 color: AppColors.textPrimary,
//                 fontSize: AppFontSizes.font16,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         top: false,
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             child: CustomCard(
//               backgroundColor: AppColors.white,
//               elevation: 0,
//               borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
//               padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: AppColors.errorLight,
//                       borderRadius: BorderRadius.circular(13),
//                     ),
//                     alignment: Alignment.center,
//                     child: SvgPicture.asset(
//                       AppAssets.icon('delete.svg'),
//                       width: 21,
//                       height: 21,
//                       colorFilter: const ColorFilter.mode(
//                         AppColors.danger,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   const Text(
//                     'Delete this word?',
//                     style: TextStyle(
//                       color: AppColors.textPrimary,
//                       fontSize: AppFontSizes.font16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     '"$word" will be removed from your saved vocabulary and '
//                     'favorites. You can always add it again.',
//                     style: const TextStyle(
//                       color: AppColors.textSecondary,
//                       fontSize: AppFontSizes.font11,
//                       height: 1.4,
//                     ),
//                   ),
//                   const SizedBox(height: 14),
//                   SizedBox(
//                     width: double.infinity,
//                     child: CustomRedButton(
//                       text: 'Delete Word',
//                       onTap: () => Navigator.pop(context, true),
//                       width: double.infinity,
//                       height: 44,
//                       borderRadius: 12,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   SizedBox(
//                     width: double.infinity,
//                     child: CustomLightButton(
//                       text: 'Keep Learning This Word',
//                       onTap: () => Navigator.pop(context, false),
//                       width: double.infinity,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
