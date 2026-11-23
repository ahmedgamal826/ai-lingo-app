import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';
import '../widgets_core/custom_button.dart';
import '../widgets_core/custom_drop_down_menu.dart';
import '../widgets_core/custom_icon_button.dart';
import '../widgets/vocabulary_field_label.dart';
import '../widgets/vocabulary_text_field.dart';

class EditedVocabularyWord {
  const EditedVocabularyWord({
    required this.word,
    required this.phonetic,
    required this.partOfSpeech,
    required this.meaning,
    required this.example,
    required this.isFavorite,
  });

  final String word;
  final String phonetic;
  final String partOfSpeech;
  final String meaning;
  final String example;
  final bool isFavorite;
}

class EditWordView extends StatefulWidget {
  const EditWordView({
    super.key,
    required this.word,
    required this.phonetic,
    required this.partOfSpeech,
    required this.meaning,
    required this.example,
    required this.isFavorite,
  });

  final String word;
  final String phonetic;
  final String partOfSpeech;
  final String meaning;
  final String example;
  final bool isFavorite;

  @override
  State<EditWordView> createState() => _EditWordViewState();
}

class _EditWordViewState extends State<EditWordView> {
  final _formKey = GlobalKey<FormState>();
  late final _wordController = TextEditingController(text: widget.word);
  late final _pronunciationController =
      TextEditingController(text: widget.phonetic);
  late final _meaningController = TextEditingController(text: widget.meaning);
  late final _exampleController = TextEditingController(text: widget.example);

  static const _partsOfSpeech = <String>[
    'Noun', 'Verb', 'Adjective', 'Adverb',
    'Pronoun', 'Preposition', 'Conjunction', 'Interjection',
  ];

  late String _partOfSpeech = _partsOfSpeech.contains(widget.partOfSpeech)
      ? widget.partOfSpeech
      : 'Noun';
  late bool _isFavorite = widget.isFavorite;

  @override
  void dispose() {
    _wordController.dispose();
    _pronunciationController.dispose();
    _meaningController.dispose();
    _exampleController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      EditedVocabularyWord(
        word: _wordController.text.trim(),
        phonetic: _pronunciationController.text.trim(),
        partOfSpeech: _partOfSpeech,
        meaning: _meaningController.text.trim(),
        example: _exampleController.text.trim(),
        isFavorite: _isFavorite,
      ),
    );
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
              'Edit Word',
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 16, 15, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Make this word your own with a personal example.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppFontSizes.font12,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 13),
                VocabularyFieldLabel('Word'),
                const SizedBox(height: 6),
                VocabularyTextField(
                  controller: _wordController,
                  label: 'Word',
                  hint: 'Enter a word',
                  capitalization: TextCapitalization.words,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Please enter a word'
                      : null,
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          VocabularyFieldLabel('Pronunciation'),
                          const SizedBox(height: 6),
                          VocabularyTextField(
                            controller: _pronunciationController,
                            label: 'Pronunciation',
                            hint: '/╔Ö╦êk╔Æm╔Öde╔¬t/',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomDropDownMenu<String>(
                        label: 'Part of speech',
                        items: _partsOfSpeech,
                        value: _partOfSpeech,
                        itemLabel: (item) => item,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _partOfSpeech = value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                VocabularyFieldLabel('Meaning'),
                const SizedBox(height: 6),
                VocabularyTextField(
                  controller: _meaningController,
                  label: 'Meaning',
                  hint: 'Write the meaning',
                  maxLines: 3,
                  minLines: 3,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Please enter the meaning'
                      : null,
                ),
                const SizedBox(height: 12),
                VocabularyFieldLabel('Example sentence'),
                const SizedBox(height: 6),
                VocabularyTextField(
                  controller: _exampleController,
                  label: 'Example sentence',
                  hint: 'Write an example sentence',
                  maxLines: 3,
                  minLines: 3,
                  capitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          setState(() => _isFavorite = !_isFavorite),
                      icon: SvgPicture.asset(
                        AppAssets.icon('Star.svg'),
                        width: 19,
                        height: 19,
                        fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(
                          _isFavorite
                              ? const Color(0xFFFFC107)
                              : AppColors.textSecondary,
                          BlendMode.srcIn,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 3),
                    const Text(
                      'Save to favorites',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppFontSizes.font11,
                      ),
                    ),
                    const Spacer(),
                    CustomIconButton(
                      icon: _isFavorite
                          ? Icons.check_circle_outline
                          : Icons.circle_outlined,
                      color: AppColors.primary,
                      size: 18,
                      onPressed: () =>
                          setState(() => _isFavorite = !_isFavorite),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 18),
          child: CustomDarkButton(
            text: 'Save Changes',
            onTap: _saveChanges,
            width: double.infinity,
            height: 44,
            borderRadius: AppDimensions.radiusMd,
          ),
        ),
      ),
    );
  }

}
