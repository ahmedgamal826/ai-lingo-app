/// Shared vocabulary word used by Vocabulary screens and Home preview.
class SavedVocabularyWord {
  SavedVocabularyWord({
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

  SavedVocabularyWord copyWith({
    String? word,
    String? phonetic,
    String? meaning,
    String? example,
    bool? favorite,
  }) {
    return SavedVocabularyWord(
      word: word ?? this.word,
      phonetic: phonetic ?? this.phonetic,
      meaning: meaning ?? this.meaning,
      example: example ?? this.example,
      favorite: favorite ?? this.favorite,
    );
  }
}
