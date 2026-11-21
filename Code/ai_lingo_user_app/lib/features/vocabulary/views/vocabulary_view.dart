import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_icon_button.dart';
import '../../progress/views/progress_view.dart';
import 'word_detail_view.dart';
import 'edit_word_view.dart';

class VocabularyView extends StatefulWidget {
  const VocabularyView({super.key});

  @override
  State<VocabularyView> createState() => _VocabularyViewState();
}

class _VocabularyViewState extends State<VocabularyView> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilter = 0;
  final List<_VocabularyWord> _words = [
    _VocabularyWord(
      word: 'Accommodate',
      phonetic: '/əˈkɒmədeɪt/ · verb',
      meaning: 'To provide what someone needs',
      example: '“Can you accommodate two more guests?”',
      favorite: true,
    ),
    _VocabularyWord(
      word: 'Reservation',
      phonetic: '/ˌrezəˈveɪʃən/ · noun',
      meaning: 'An arrangement to keep a place',
      example: '“I have a reservation for seven.”',
      favorite: true,
    ),
    _VocabularyWord(
      word: 'Recommend',
      phonetic: '/ˌrekəˈmend/ · verb',
      meaning: 'To suggest a good choice',
      example: '“What dish would you recommend?”',
      favorite: false,
    ),
    _VocabularyWord(
      word: 'Confident',
      phonetic: '/ˈkɒnfɪdənt/ · adjective',
      meaning: 'Feeling sure about your ability',
      example: '“I feel more confident speaking.”',
      favorite: false,
    ),
  ];

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
                    phonetic: '· new word',
                    meaning: meaning,
                    example: 'Tap to add an example sentence.',
                  ),
                );
                _selectedFilter = 0;
                _searchController.clear();
              });
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
                  '128 WORDS · A GROWING WORLD',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppFontSizes.font9,
                    letterSpacing: .15,
                  ),
                ),
              ],
            ),
            actions: [
              CustomIconButton(
                onPressed: _showAddWordDialog,
                tooltip: 'Add word',
                icon: Icons.add,
                color: AppColors.primary,
                size: 23,
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
                            _buildSearchField(),
                            const SizedBox(height: 11),
                            _buildFilterTabs(),
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
                                  onTap: _showAddWordDialog,
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
                        ..._visibleWords.map(
                          (word) => _buildWordCard(word),
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
        bottomNavigationBar: CustomBottomNavBar(
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
            const BottomNavItem(label: 'Progress', icon: Icons.bar_chart),
            BottomNavItem(
              label: 'Profile',
              icon: Icons.person_outline,
              iconAsset: AppAssets.icon('user-round.svg'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: AppFontSizes.font13,
        ),
        decoration: InputDecoration(
          hintText: 'Search your saved words',
          hintStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppFontSizes.font11,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 11, right: 8),
            child: SvgPicture.asset(
              AppAssets.icon('search.svg'),
              width: 14,
              height: 14,
              colorFilter: const ColorFilter.mode(
                AppColors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 34),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            borderSide: const BorderSide(color: AppColors.primarySoft),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 34,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.indicatorInactive,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(child: _filterTab('All words · 128', 0)),
          Expanded(child: _filterTab('Favorites · $_favoriteCount', 1)),
        ],
      ),
    );
  }

  Widget _filterTab(String label, int index) {
    final selected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.primary : AppColors.textSecondary,
            fontSize: AppFontSizes.font11,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _openWordDetail(_VocabularyWord word) {
    // Keep the richer Figma copy for the reference word; all other entries
    // use the data already stored in their Vocabulary card.
    final isAccommodate = word.word.toLowerCase() == 'accommodate';
    final phoneticParts = word.phonetic.split('·');
    final phonetic = isAccommodate
        ? '/əˈkɒmədeɪt/'
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
              ? '“The restaurant can accommodate a group of twelve.”'
              : word.example,
          source: isAccommodate
              ? 'Saved from Restaurant · Nov 9, 2026'
              : 'Saved to Vocabulary',
          isFavorite: word.favorite,
          relatedExpressions: isAccommodate
              ? const ['Make room for', 'Provide for', 'Host']
              : const [],
          onWordUpdated: (updated) {
            setState(() {
              word.word = updated.word;
              word.phonetic =
                  '${updated.phonetic} · ${updated.partOfSpeech.toLowerCase()}';
              word.meaning = updated.meaning;
              word.example = updated.example;
              word.favorite = updated.isFavorite;
            });
          },
          onWordDeleted: () {
            setState(() {
              _words.remove(word);
            });
          },
        ),
      ),
    );
  }

  Widget _buildWordCard(_VocabularyWord word) {
    // Figma card frame: 350 x 102. The height includes the card's padding.
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 102,
        child: CustomCard(
          backgroundColor: AppColors.white,
          elevation: 0,
          borderRadius: BorderRadius.circular(13),
          onTap: () => _openWordDetail(word),
          padding: const EdgeInsets.fromLTRB(12, 8, 10, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      word.word,
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
                  _smallIconButton(
                    icon: Icons.volume_up_outlined,
                    color: AppColors.primary,
                    onTap: () {},
                  ),
                  const SizedBox(width: 3),
                  _smallIconButton(
                    icon: word.favorite ? Icons.star : Icons.star_border,
                    color: word.favorite
                        ? const Color(0xFFC58A28)
                        : AppColors.textSecondary,
                    onTap: () => setState(() => word.favorite = !word.favorite),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                word.phonetic,
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
                word.meaning,
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
                word.example,
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

  Widget _smallIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomIconButton(
        icon: icon,
        onPressed: onTap,
        color: color,
        size: 14,
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
}

