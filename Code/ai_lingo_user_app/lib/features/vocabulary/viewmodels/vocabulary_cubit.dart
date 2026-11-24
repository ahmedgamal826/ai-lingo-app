import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/saved_vocabulary_word.dart';
import 'vocabulary_state.dart';

/// Shared vocabulary presentation state for Vocabulary + Home.
class VocabularyCubit extends Cubit<VocabularyState> {
  VocabularyCubit() : super(VocabularyState.initial());

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void setFilter(int index) {
    if (index == state.selectedFilter) return;
    emit(state.copyWith(selectedFilter: index));
  }

  void addWord(SavedVocabularyWord word) {
    emit(state.copyWith(words: [word, ...state.words], selectedFilter: 0, searchQuery: ''));
  }

  void updateWord(SavedVocabularyWord original, SavedVocabularyWord updated) {
    final words = [...state.words];
    final index = words.indexOf(original);
    if (index < 0) return;
    words[index] = updated;
    emit(state.copyWith(words: words));
  }

  void toggleFavorite(SavedVocabularyWord word) {
    final words = [...state.words];
    final index = words.indexOf(word);
    if (index < 0) return;
    words[index] = word.copyWith(favorite: !word.favorite);
    emit(state.copyWith(words: words));
  }

  void deleteWord(SavedVocabularyWord word) {
    final words = [...state.words]..remove(word);
    emit(state.copyWith(words: words));
  }
}
