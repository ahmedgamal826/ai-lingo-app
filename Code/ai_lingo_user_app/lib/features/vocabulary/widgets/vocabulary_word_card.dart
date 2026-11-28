import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_font_sizes.dart';
import '../widgets_core/custom_card.dart';

class VocabularyWordCard extends StatelessWidget {
  const VocabularyWordCard({
    super.key,
    required this.word,
    required this.phonetic,
    required this.meaning,
    required this.example,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
    required this.onSpeakerTap,
  });

  final String word;
  final String phonetic;
  final String meaning;
  final String example;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final VoidCallback onSpeakerTap;

  Widget _iconButton(String assetName, Color color, VoidCallback onPressed) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Center(
          child: SvgPicture.asset(
            AppAssets.icon(assetName),
            width: 16,
            height: 16,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 102,
        child: CustomCard(
          backgroundColor: AppColors.white,
          elevation: 0,
          borderRadius: BorderRadius.circular(13),
          onTap: onTap,
          padding: const EdgeInsets.fromLTRB(12, 8, 10, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      word,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppFontSizes.font16,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _iconButton('Speaker.svg', AppColors.primary, onSpeakerTap),
                  const SizedBox(width: 3),
                  _iconButton(
                    'Star.svg',
                    isFavorite
                        ? const Color(0xFFC58A28)
                        : AppColors.textSecondary,
                    onFavoriteTap,
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                phonetic,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppFontSizes.font11,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                meaning,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppFontSizes.font13,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                example,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppFontSizes.font11,
                  height: 1.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
