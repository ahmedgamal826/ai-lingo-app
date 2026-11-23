import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets_core/custom_button.dart';
import '../widgets_core/custom_card.dart';
import '../widgets_core/custom_icon_button.dart';

import 'edit_word_view.dart';
import 'delete_word_confirmation_view.dart';
import '../widgets/vocabulary_pill.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';

class WordDetailView extends StatefulWidget {
  const WordDetailView({
    super.key,
    this.word = 'Accommodate',
    this.phonetic = '/╔Ö╦êk╔Æm╔Öde╔¬t/',
    this.partOfSpeech = 'Verb',
    this.meaning = 'To provide someone with a place to stay, or to meet their needs.',
    this.example = 'ΓÇ£The restaurant can accommodate a group of twelve.ΓÇ¥',
    this.source = 'Saved from Restaurant ┬╖ Nov 9, 2026',
    this.relatedExpressions = const ['Make room for', 'Provide for', 'Host'],
    this.isFavorite = true,
    this.onWordUpdated, this.onWordDeleted,
  });

  final String word;
  final String phonetic;
  final String partOfSpeech;
  final String meaning;
  final String example;
  final String source;
  final List<String> relatedExpressions;
  final bool isFavorite;
  final ValueChanged<EditedVocabularyWord>? onWordUpdated;
  final VoidCallback? onWordDeleted;

  @override
  State<WordDetailView> createState() => _WordDetailViewState();
}

class _WordDetailViewState extends State<WordDetailView> {
  late bool _isFavorite = widget.isFavorite;
  late String _word = widget.word;
  late String _phonetic = widget.phonetic;
  late String _partOfSpeech = widget.partOfSpeech;
  late String _meaning = widget.meaning;
  late String _example = widget.example;

  Future<void> _editWord() async {
    final updated = await Navigator.push<EditedVocabularyWord>(
      context,
      MaterialPageRoute(
        builder: (_) => EditWordView(
          word: _word,
          phonetic: _phonetic,
          partOfSpeech: _partOfSpeech,
          meaning: _meaning,
          example: _example,
          isFavorite: _isFavorite,
        ),
      ),
    );
    if (updated == null || !mounted) return;
    setState(() {
      _word = updated.word;
      _phonetic = updated.phonetic;
      _partOfSpeech = updated.partOfSpeech;
      _meaning = updated.meaning;
      _example = updated.example;
      _isFavorite = updated.isFavorite;
    });
    widget.onWordUpdated?.call(updated);
  }

  Future<void> _deleteWord() async {
    final shouldDelete = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => DeleteWordConfirmationView(word: _word),
      ),
    );

    // Only leave Word Detail after the user confirms the deletion.
    // Choosing "Keep Learning This Word" returns to Word Detail unchanged.
    if (shouldDelete == true && mounted) {
      widget.onWordDeleted?.call();
      Navigator.pop(context);
    }
  }

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
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 8),
            const Text(
              'Word detail',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: AppFontSizes.font16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          CustomIconButton(
            icon: _isFavorite ? Icons.star : Icons.star_border,
            color: AppColors.primary,
            size: 23,
            onPressed: () => setState(() => _isFavorite = !_isFavorite),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(19, 17, 19, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomCard(
                backgroundColor: AppColors.primaryLight,
                elevation: 0,
                borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            _word,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: AppFontSizes.font26,
                              height: 1.15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -4),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {},
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: Center(
                                child: SvgPicture.asset(
                                  AppAssets.icon('Speaker.svg'),
                                  width: 16,
                                  height: 16,
                                  fit: BoxFit.contain,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _phonetic,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: AppFontSizes.font12,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        VocabularyPill(
                          label: _partOfSpeech,
                          background: AppColors.primaryLight,
                          foreground: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        if (_isFavorite)
                          VocabularyPill(
                            label: 'Γÿà Favorite',
                            background: AppColors.warningLight,
                            foreground: AppColors.warning,
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.source,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: AppFontSizes.font11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Meaning',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppFontSizes.font15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _meaning,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppFontSizes.font15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              CustomCard(
                backgroundColor: AppColors.white,
                elevation: 0,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                padding: const EdgeInsets.fromLTRB(13, 14, 13, 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Put it into practice',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppFontSizes.font12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      _example,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppFontSizes.font13,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 9),
                    const Text(
                      'Try using it when making a reservation.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: AppFontSizes.font11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Related expressions',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppFontSizes.font15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: widget.relatedExpressions
                    .map(
                      (expression) => VocabularyPill(
                        label: expression,
                        background: AppColors.primaryLight,
                        foreground: AppColors.primary,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(19, 8, 19, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: CustomDarkButton(
                  text: 'Edit Word',
                  onTap: _editWord,
                  width: double.infinity,
                  height: 44,
                  borderRadius: 12,
                  leading: SvgPicture.asset(
                    AppAssets.icon('pencil.svg'),
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: CustomRedButton(
                  text: 'Delete Word',
                  onTap: _deleteWord,
                  width: double.infinity,
                  height: 44,
                  borderRadius: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
