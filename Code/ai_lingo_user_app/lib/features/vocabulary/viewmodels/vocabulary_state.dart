import '../models/saved_vocabulary_word.dart';

class VocabularyState {
  const VocabularyState({
    required this.words,
    this.selectedFilter = 0,
    this.searchQuery = '',
  });

  factory VocabularyState.initial() {
    return VocabularyState(
      words: [
        SavedVocabularyWord(
          word: 'Accommodate',
          phonetic: '/əˈkɑːmədeɪt/ · verb',
          meaning: 'To provide what someone needs',
          example: '“Can you accommodate two more guests?”',
          favorite: true,
        ),
        SavedVocabularyWord(
          word: 'Reservation',
          phonetic: '/ˌrezərˈveɪʃən/ · noun',
          meaning: 'An arrangement to keep a place',
          example: '“I have a reservation for seven.”',
          favorite: true,
        ),
        SavedVocabularyWord(
          word: 'Recommend',
          phonetic: '/ˌrekəˈmend/ · verb',
          meaning: 'To suggest a good choice',
          example: '“What dish would you recommend?”',
          favorite: false,
        ),
        SavedVocabularyWord(
          word: 'Confident',
          phonetic: '/ˈkɑːnfɪdənt/ · adjective',
          meaning: 'Feeling sure about your ability',
          example: '“I feel more confident speaking.”',
          favorite: false,
        ),
      ],
    );
  }

  final List<SavedVocabularyWord> words;
  final int selectedFilter;
  final String searchQuery;

  List<SavedVocabularyWord> get visibleWords {
    final query = searchQuery.trim().toLowerCase();
    return words.where((word) {
      final matchesFilter = selectedFilter == 0 || word.favorite;
      final matchesSearch = query.isEmpty ||
          word.word.toLowerCase().contains(query) ||
          word.meaning.toLowerCase().contains(query);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  int get favoriteCount =>
      16 + words.where((word) => word.favorite).length - 2;

  /// Prefer a favorite word for Home preview; otherwise the newest word.
  SavedVocabularyWord? get previewWord {
    if (words.isEmpty) return null;
    for (final word in words) {
      if (word.favorite) return word;
    }
    return words.first;
  }

  VocabularyState copyWith({
    List<SavedVocabularyWord>? words,
    int? selectedFilter,
    String? searchQuery,
  }) {
    return VocabularyState(
      words: words ?? this.words,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
