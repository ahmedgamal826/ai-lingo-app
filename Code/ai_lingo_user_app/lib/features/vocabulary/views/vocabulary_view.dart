import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';
import '../../progress/views/progress_view.dart';
import '../widgets_core/custom_bottom_nav_bar.dart';
import 'add_word_view.dart';
import 'word_detail_view.dart';
import 'edit_word_view.dart';
import '../widgets/vocabulary_search_field.dart';
import '../widgets/vocabulary_filter_tabs.dart';
import '../widgets/vocabulary_word_card.dart';

class VocabularyView extends StatefulWidget {
  const VocabularyView({super.key, this.showBottomNav = true});

  final bool showBottomNav;

  @override
  State<VocabularyView> createState() => _VocabularyViewState();
}

class _VocabularyViewState extends State<VocabularyView> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilter = 0;
  final List<_VocabularyWord> _words = [
    _VocabularyWord(
      word: 'Accommodate',
      phonetic: '/╔Ö╦êk╔Æm╔Öde╔¬t/ ┬╖ verb',
      meaning: 'To provide what someone needs',
      example: 'ΓÇ£Can you accommodate two more guests?ΓÇ¥',
      favorite: true,
    ),
    _VocabularyWord(
      word: 'Reservation',
      phonetic: '/╦îrez╔Ö╦êve╔¬╩â╔Ön/ ┬╖ noun',
      meaning: 'An arrangement to keep a place',
      example: 'ΓÇ£I have a reservation for seven.ΓÇ¥',
      favorite: true,
    ),
    _VocabularyWord(
      word: 'Recommend',
      phonetic: '/╦îrek╔Ö╦êmend/ ┬╖ verb',
      meaning: 'To suggest a good choice',
      example: 'ΓÇ£What dish would you recommend?ΓÇ¥',
      favorite: false,
    ),
    _VocabularyWord(
      word: 'Confident',
      phonetic: '/╦êk╔Ænf╔¬d╔Önt/ ┬╖ adjective',
      meaning: 'Feeling sure about your ability',
      example: 'ΓÇ£I feel more confident speaking.ΓÇ¥',
      favorite: false,
    ),
  ];

  static const String _storageKey = 'saved_vocabulary_words_v1';

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  Future<void> _loadWords() async {
    final preferences = await SharedPreferences.getInstance();
    final storedWords = preferences.getString(_storageKey);

    if (!mounted) return;
    if (storedWords == null) {
      await _saveWords();
      return;
    }

    try {
      final decoded = jsonDecode(storedWords) as List<dynamic>;
      setState(() {
        _words
          ..clear()
          ..addAll(decoded.map(
            (item) => _VocabularyWord.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          ));
      });
    } catch (_) {
      // Keep the existing starter words if stored data is invalid.
      await _saveWords();
    }
  }

  Future<void> _saveWords() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      _storageKey,
      jsonEncode(_words.map((word) => word.toJson()).toList()),
    );
  }

  List<_VocabularyWord> get _visibleWords {
    final query = _searchController.text.trim().toLowerCase();
    return _words.where((word) {
      final matchesFilter = _selectedFilter == 0 || word.favorite;
      final matchesSearch = query.isEmpty ||
          word.word.toLowerCase().contains(query) ||
          word.meaning.toLowerCase().contains(query);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  int get _favoriteCount =>
      16 + _words.where((word) => word.favorite).length - 2;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openAddWordPage() async {
    final result = await Navigator.push<AddedVocabularyWord>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddWordView(),
      ),
    );

    if (result == null || !mounted) return;

    setState(() {
      _words.insert(
        0,
        _VocabularyWord(
          word: result.word,
          phonetic: result.phonetic.isEmpty
              ? result.partOfSpeech.toLowerCase()
              : '${result.phonetic} ┬╖ ${result.partOfSpeech.toLowerCase()}',
          meaning: result.meaning,
          example: result.example,
          favorite: result.isFavorite,
        ),
      );

      _selectedFilter = 0;
      _searchController.clear();
    });
    await _saveWords();
  }



  void _showAddWordDialog() {
    final wordController = TextEditingController();
    final meaningController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add new word'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: wordController,
              decoration: const InputDecoration(hintText: 'Word'),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: meaningController,
              decoration: const InputDecoration(hintText: 'Meaning'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newWord = wordController.text.trim();
              final meaning = meaningController.text.trim();
              if (newWord.isEmpty || meaning.isEmpty) return;
              setState(() {
                _words.insert(
                  0,
                  _VocabularyWord(
                    word: newWord,
                    phonetic: '┬╖ new word',
                    meaning: meaning,
                    example: 'Tap to add an example sentence.',
                  ),
                );
                _selectedFilter = 0;
                _searchController.clear();
              });
              _saveWords();
              Navigator.pop(dialogContext);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    ).whenComplete(() {
      wordController.dispose();
      meaningController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        navigationBarTheme: NavigationBarThemeData(
          height: AppDimensions.bottomNavHeight,
          backgroundColor: AppColors.white,
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              fontSize: AppFontSizes.font10,
              height: 1.2,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(
              size: 19,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            );
          }),
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FC),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(74),
          child: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 74,
            backgroundColor: AppColors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 20,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Vocabulary',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppFontSizes.font20,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '128 WORDS ┬╖ A GROWING WORLD',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppFontSizes.font9,
                    letterSpacing: .15,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: _openAddWordPage,
                tooltip: 'Add word',
                icon: SvgPicture.asset(
                  AppAssets.icon('plus.svg'),
                  width: 23,
                  height: 23,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        body: SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 13, 14, 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            VocabularySearchField(controller: _searchController, onChanged: (_) => setState(() {})),
                            const SizedBox(height: 11),
                            VocabularyFilterTabs(selectedFilter: _selectedFilter, favoriteCount: _favoriteCount, onChanged: (index) => setState(() => _selectedFilter = index)),
                            const SizedBox(height: 11),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Recently saved',
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: AppFontSizes.font16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _openAddWordPage,
                                  child: const Text(
                                    'Add word +',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: AppFontSizes.font12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(height: 16),
                        ..._visibleWords.map(
                          (word) => VocabularyWordCard(word: word.word, phonetic: word.phonetic, meaning: word.meaning, example: word.example, isFavorite: word.favorite, onTap: () => _openWordDetail(word), onFavoriteTap: () { setState(() => word.favorite = !word.favorite); _saveWords(); }),
                        ),
                        if (_visibleWords.isEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 36),
                            child: Center(
                              child: Text(
                                'No words found',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: AppFontSizes.font13,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: (widget.showBottomNav ? CustomBottomNavBar(
          currentIndex: 2,
          onTap: (index) {
            if (index == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ProgressView()),
              );
            }
          },
          items: [
            const BottomNavItem(label: 'Home', icon: Icons.home_outlined),
            BottomNavItem(
              label: 'Practice',
              icon: Icons.forum_outlined,
              iconAsset: AppAssets.icon('messages-square.svg'),
            ),
            BottomNavItem(
              label: 'Vocabulary',
              icon: Icons.menu_book_outlined,
              iconAsset: AppAssets.icon('book-open.svg'),
            ),
            BottomNavItem(
              label: 'Progress',
              icon: Icons.bar_chart,
              iconAsset: AppAssets.icon('Progress.svg'),
            ),
            BottomNavItem(
              label: 'Profile',
              icon: Icons.person_outline,
              iconAsset: AppAssets.icon('user-round.svg'),
            ),
          ],
        ) : null),
      ),
    );
  }

  void _openWordDetail(_VocabularyWord word) {
    // Keep the richer Figma copy for the reference word; all other entries
    // use the data already stored in their Vocabulary card.
    final isAccommodate = word.word.toLowerCase() == 'accommodate';
    final phoneticParts = word.phonetic.split('┬╖');
    final phonetic = isAccommodate
        ? '/╔Ö╦êk╔Æm╔Öde╔¬t/'
        : phoneticParts.first.trim();
    final partOfSpeech = isAccommodate
        ? 'Verb'
        : (phoneticParts.length > 1 ? phoneticParts[1].trim() : 'Word');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WordDetailView(
          word: word.word,
          phonetic: phonetic,
          partOfSpeech: partOfSpeech,
          meaning: isAccommodate
              ? 'To provide someone with a place to stay, or to meet their needs.'
              : word.meaning,
          example: isAccommodate
              ? 'ΓÇ£The restaurant can accommodate a group of twelve.ΓÇ¥'
              : word.example,
          source: isAccommodate
              ? 'Saved from Restaurant ┬╖ Nov 9, 2026'
              : 'Saved to Vocabulary',
          isFavorite: word.favorite,
          relatedExpressions: isAccommodate
              ? const ['Make room for', 'Provide for', 'Host']
              : const [],
          onWordUpdated: (updated) {
            setState(() {
              word.word = updated.word;
              word.phonetic =
                  '${updated.phonetic} ┬╖ ${updated.partOfSpeech.toLowerCase()}';
              word.meaning = updated.meaning;
              word.example = updated.example;
              word.favorite = updated.isFavorite;
            });
            _saveWords();
          },
          onWordDeleted: () {
            setState(() {
              _words.remove(word);
            });
            _saveWords();
          },
        ),
      ),
    );
  }


}

class _VocabularyWord {
  _VocabularyWord({
    required this.word,
    required this.phonetic,
    required this.meaning,
    required this.example,
    this.favorite = false,
  });

  String word;
  String phonetic;
  String meaning;
  String example;
  bool favorite;

  Map<String, dynamic> toJson() => {
        'word': word,
        'phonetic': phonetic,
        'meaning': meaning,
        'example': example,
        'favorite': favorite,
      };

  factory _VocabularyWord.fromJson(Map<String, dynamic> json) {
    return _VocabularyWord(
      word: json['word'] as String? ?? '',
      phonetic: json['phonetic'] as String? ?? '',
      meaning: json['meaning'] as String? ?? '',
      example: json['example'] as String? ?? '',
      favorite: json['favorite'] as bool? ?? false,
    );
  }
}
