import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_drop_down_menu.dart';
import '../../../core/widgets/custom_icon_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class AddedVocabularyWord {
  const AddedVocabularyWord({
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

class AddWordView extends StatefulWidget {
  const AddWordView({super.key});

  @override
  State<AddWordView> createState() => _AddWordViewState();
}

class _AddWordViewState extends State<AddWordView> {
  final _formKey = GlobalKey<FormState>();
  final _wordController = TextEditingController();
  final _pronunciationController = TextEditingController();
  final _meaningController = TextEditingController();
  final _exampleController = TextEditingController();

  static const _partsOfSpeech = <String>[
    'Noun',
    'Verb',
    'Adjective',
    'Adverb',
    'Pronoun',
    'Preposition',
    'Conjunction',
    'Interjection',
  ];

  String _partOfSpeech = 'Adjective';
  bool _isFavorite = false;

  @override
  void dispose() {
    _wordController.dispose();
    _pronunciationController.dispose();
    _meaningController.dispose();
    _exampleController.dispose();
    super.dispose();
  }

  void _saveWord() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(
      context,
      AddedVocabularyWord(
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
              'Add a Word',
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
            padding: const EdgeInsets.fromLTRB(19, 16, 19, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Found a useful word? Give it a home in your vocabulary.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppFontSizes.font12,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 13),
                _fieldLabel('Word'),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: _wordController,
                  label: 'Word',
                  showLabel: false,
                  hint: 'Enter a word',
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 13,
                  ),
                  fontSize: AppFontSizes.font12,
                  validator: (value) =>
                      value == null || value.trim().isEmpty
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
                          _pronunciationFieldLabel(),
                          const SizedBox(height: 6),
                          CustomTextField(
                            controller: _pronunciationController,
                            label: 'Pronunciation',
                            showLabel: false,
                            hint: '/ˈrɪzɪliənt/',
                            textInputAction: TextInputAction.next,
                            filled: true,
                            fillColor: AppColors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 13,
                            ),
                            fontSize: AppFontSizes.font12,
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
                _fieldLabel('Meaning'),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: _meaningController,
                  label: 'Meaning',
                  showLabel: false,
                  hint: 'Write the meaning',
                  maxLines: 3,
                  minLines: 3,
                  textInputAction: TextInputAction.newline,
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  fontSize: AppFontSizes.font12,
                  validator: (value) =>
                      value == null || value.trim().isEmpty
                          ? 'Please enter the meaning'
                          : null,
                ),
                const SizedBox(height: 12),
                _fieldLabel('Example sentence'),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: _exampleController,
                  label: 'Example sentence',
                  showLabel: false,
                  hint: 'Write an example sentence',
                  maxLines: 3,
                  minLines: 3,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  fontSize: AppFontSizes.font12,
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
          padding: const EdgeInsets.fromLTRB(19, 8, 19, 18),
          child: CustomDarkButton(
            text: 'Add Word',
            onTap: _saveWord,
            width: double.infinity,
            height: 44,
            borderRadius: 12,
          ),
        ),
      ),
    );
  }

  Widget _pronunciationFieldLabel() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: AppFontSizes.font11,
          fontWeight: FontWeight.w600,
        ),
        children: const [
          TextSpan(
            text: 'Pronunciation ',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          TextSpan(
            text: '(optional)',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: AppFontSizes.font11,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
