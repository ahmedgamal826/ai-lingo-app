import 'package:flutter/material.dart';

import '../../vocabulary/views/vocabulary_view.dart';

/// App entry screen currently displays the Vocabulary screen.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => const VocabularyView();
}
