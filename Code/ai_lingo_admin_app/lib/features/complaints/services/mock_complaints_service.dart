import '../models/complaint_models.dart';
import 'complaints_service.dart';

/// Temporary local complaints source until a backend endpoint exists.
class MockComplaintsService implements ComplaintsService {
  factory MockComplaintsService() => instance;

  MockComplaintsService._();

  static final MockComplaintsService instance = MockComplaintsService._();

  static const Duration latency = Duration(milliseconds: 350);

  final List<ComplaintItem> _seed = _buildSeed();

  @override
  Future<List<String>> fetchCategories() async {
    await Future<void>.delayed(latency);
    final categories = _seed.map((e) => e.category).toSet().toList()..sort();
    return categories;
  }

  @override
  Future<ComplaintsPage> fetchComplaints(ComplaintsQuery query) async {
    await Future<void>.delayed(latency);

    var filtered = List<ComplaintItem>.from(_seed);

    switch (query.statusTab) {
      case ComplaintStatusTab.all:
        break;
      case ComplaintStatusTab.pending:
        filtered = filtered
            .where((item) => item.status == ComplaintStatus.pending)
            .toList();
      case ComplaintStatusTab.resolved:
        filtered = filtered
            .where((item) => item.status == ComplaintStatus.resolved)
            .toList();
    }

    if (query.category != null && query.category!.isNotEmpty) {
      filtered = filtered
          .where((item) => item.category == query.category)
          .toList();
    }

    final search = query.searchQuery.trim().toLowerCase();
    if (search.isNotEmpty) {
      filtered = filtered.where((item) {
        return item.learnerName.toLowerCase().contains(search) ||
            item.title.toLowerCase().contains(search) ||
            item.id.toLowerCase().contains(search) ||
            item.description.toLowerCase().contains(search);
      }).toList();
    }

    filtered.sort((a, b) {
      final cmp = a.submittedAt.compareTo(b.submittedAt);
      return query.sort == ComplaintSort.newestFirst ? -cmp : cmp;
    });

    final pendingCount = _seed
        .where((item) => item.status == ComplaintStatus.pending)
        .length;
    final resolvedCount = _seed
        .where((item) => item.status == ComplaintStatus.resolved)
        .length;

    final start = query.offset.clamp(0, filtered.length);
    final end = (query.offset + query.limit).clamp(0, filtered.length);
    final pageItems = filtered.sublist(start, end);

    return ComplaintsPage(
      items: pageItems,
      filteredTotal: filtered.length,
      allCount: _seed.length,
      pendingCount: pendingCount,
      resolvedCount: resolvedCount,
      hasMore: end < filtered.length,
    );
  }

  @override
  Future<ComplaintItem> fetchComplaintById(String id) async {
    await Future<void>.delayed(latency);
    final match = _seed.where((item) => item.id == id);
    if (match.isEmpty) {
      throw StateError('Complaint $id was not found.');
    }
    return match.first;
  }

  @override
  Future<ComplaintItem> submitReply(ComplaintReplyRequest request) async {
    await Future<void>.delayed(latency);
    final index = _seed.indexWhere((item) => item.id == request.complaintId);
    if (index < 0) {
      throw StateError('Complaint ${request.complaintId} was not found.');
    }

    final updated = _seed[index].copyWith(
      status: request.status,
      adminReply: request.reply.trim(),
      description: request.reply.trim().length > 90
          ? '${request.reply.trim().substring(0, 87)}...'
          : request.reply.trim(),
    );
    _seed[index] = updated;
    return updated;
  }

  static List<ComplaintItem> _buildSeed() {
    final items = <ComplaintItem>[
      ComplaintItem(
        id: 'C-1042',
        learnerName: 'Alex Carter',
        learnerEmail: 'alex.carter@university.edu',
        initials: 'AC',
        title: 'Weekly test score looks incorrect',
        description:
            'My answer to question 8 was marked incorrect. Please review it.',
        message:
            'My answer to question 8 in Week 46 was marked incorrect. I selected "I visited London last year." Could you please review it?',
        status: ComplaintStatus.inProgress,
        category: 'Weekly Test',
        categoryLabel: 'Quiz & scoring',
        submittedAt: DateTime(2026, 11, 15, 20, 12),
        relatedResource: const ComplaintRelatedResource(
          label: 'View Week 46 result',
          scoreLabel: 'Score 90/100',
          canOpen: false,
        ),
        adminReply:
            'Thanks for flagging this, Alex. You\'re right! We corrected the answer key and updated your score from 85 to 90. Your leaderboard points have also been updated. Happy learning!',
      ),
      ComplaintItem(
        id: 'C-1041',
        learnerName: 'Mia Chen',
        learnerEmail: 'mia.chen@university.edu',
        initials: 'MC',
        title: 'Unable to open weekly test',
        description: 'The Start Test button keeps loading on my phone.',
        message:
            'The Start Test button keeps loading on my phone and never opens the weekly quiz. I tried restarting the app twice.',
        status: ComplaintStatus.pending,
        category: 'Weekly Test',
        categoryLabel: 'Quiz & scoring',
        submittedAt: DateTime(2026, 11, 15, 18, 35),
      ),
      ComplaintItem(
        id: 'C-1038',
        learnerName: 'Alex Carter',
        learnerEmail: 'alex.carter@university.edu',
        initials: 'AC',
        title: 'Conversation audio is too quiet',
        description: 'The AI voice is difficult to hear with headphones.',
        message:
            'The AI voice is difficult to hear with headphones even at maximum volume during restaurant practice.',
        status: ComplaintStatus.inProgress,
        category: 'Conversation',
        categoryLabel: 'Conversation',
        submittedAt: DateTime(2026, 11, 12, 16, 20),
      ),
      ComplaintItem(
        id: 'C-1037',
        learnerName: 'Sara Nabil',
        learnerEmail: 'sara.nabil@university.edu',
        initials: 'SN',
        title: 'Hint text is cut off',
        description: 'On small phones the hint card overlaps the keyboard.',
        message:
            'On small phones the hint card overlaps the keyboard and I cannot read the full suggestion.',
        status: ComplaintStatus.pending,
        category: 'Conversation',
        categoryLabel: 'Conversation',
        submittedAt: DateTime(2026, 11, 12, 11, 5),
      ),
      ComplaintItem(
        id: 'C-1036',
        learnerName: 'Omar Hassan',
        learnerEmail: 'omar.hassan@university.edu',
        initials: 'OH',
        title: 'Wrong level shown on profile',
        description: 'My profile still says A2 after the placement update.',
        message:
            'My profile still says A2 after the placement update even though I completed B1.',
        status: ComplaintStatus.resolved,
        category: 'Profile',
        categoryLabel: 'Profile',
        submittedAt: DateTime(2026, 11, 11, 19, 40),
        adminReply:
            'Thanks Omar — we refreshed your placement result. Please reopen Profile.',
      ),
      ComplaintItem(
        id: 'C-1035',
        learnerName: 'Lina Farouk',
        learnerEmail: 'lina.farouk@university.edu',
        initials: 'LF',
        title: 'Cannot submit final answer',
        description: 'Next Question stays disabled on the last item.',
        message:
            'Next Question stays disabled on the last item so I cannot finish the weekly test.',
        status: ComplaintStatus.pending,
        category: 'Weekly Test',
        categoryLabel: 'Quiz & scoring',
        submittedAt: DateTime(2026, 11, 11, 14, 18),
      ),
      ComplaintItem(
        id: 'C-1034',
        learnerName: 'James Lee',
        learnerEmail: 'james.lee@university.edu',
        initials: 'JL',
        title: 'Notification badge stuck',
        description: 'The bell still shows 3 after I opened everything.',
        message:
            'The bell still shows 3 after I opened everything in notifications.',
        status: ComplaintStatus.resolved,
        category: 'Notifications',
        categoryLabel: 'Notifications',
        submittedAt: DateTime(2026, 11, 10, 21, 2),
        adminReply:
            'Badge cache was cleared on our side. Please force refresh.',
      ),
      ComplaintItem(
        id: 'C-1033',
        learnerName: 'Nora Ali',
        learnerEmail: 'nora.ali@university.edu',
        initials: 'NA',
        title: 'Scenario card opens blank',
        description: 'Travel scenario opens an empty conversation screen.',
        message:
            'Travel scenario opens an empty conversation screen with no AI greeting.',
        status: ComplaintStatus.pending,
        category: 'Conversation',
        categoryLabel: 'Conversation',
        submittedAt: DateTime(2026, 11, 10, 9, 45),
      ),
      ComplaintItem(
        id: 'C-1032',
        learnerName: 'Pedro Silva',
        learnerEmail: 'pedro.silva@university.edu',
        initials: 'PS',
        title: 'Leaderboard rank mismatch',
        description: 'Home shows #12 but leaderboard lists me at #15.',
        message:
            'Home shows #12 but leaderboard lists me at #15 for the same week.',
        status: ComplaintStatus.inProgress,
        category: 'Progress',
        categoryLabel: 'Progress',
        submittedAt: DateTime(2026, 11, 9, 17, 30),
      ),
      ComplaintItem(
        id: 'C-1031',
        learnerName: 'Hana Youssef',
        learnerEmail: 'hana.youssef@university.edu',
        initials: 'HY',
        title: 'Dark icons on dark mode',
        description: 'Bottom navigation icons disappear in system dark mode.',
        message:
            'Bottom navigation icons disappear in system dark mode on Android 14.',
        status: ComplaintStatus.resolved,
        category: 'UI',
        categoryLabel: 'UI',
        submittedAt: DateTime(2026, 11, 9, 12, 10),
        adminReply: 'Icon contrast was fixed in the latest build.',
      ),
      ComplaintItem(
        id: 'C-1030',
        learnerName: 'Kevin Brown',
        learnerEmail: 'kevin.brown@university.edu',
        initials: 'KB',
        title: 'Timer jumps during quiz',
        description: 'Remaining time skipped from 12:00 to 09:40 once.',
        message:
            'Remaining time skipped from 12:00 to 09:40 once during Week 45.',
        status: ComplaintStatus.pending,
        category: 'Weekly Test',
        categoryLabel: 'Quiz & scoring',
        submittedAt: DateTime(2026, 11, 8, 20, 55),
      ),
      ComplaintItem(
        id: 'C-1029',
        learnerName: 'Amira Said',
        learnerEmail: 'amira.said@university.edu',
        initials: 'AS',
        title: 'Vocabulary audio fails',
        description: 'Tapping the speaker icon does nothing for Accommodate.',
        message:
            'Tapping the speaker icon does nothing for the word Accommodate.',
        status: ComplaintStatus.resolved,
        category: 'Vocabulary',
        categoryLabel: 'Vocabulary',
        submittedAt: DateTime(2026, 11, 8, 15, 22),
        adminReply: 'Audio asset was re-uploaded. Please try again.',
      ),
      ComplaintItem(
        id: 'C-1028',
        learnerName: 'Daniel Okoro',
        learnerEmail: 'daniel.okoro@university.edu',
        initials: 'DO',
        title: 'Continue Learning goes nowhere',
        description:
            'After evaluation, Continue Learning returns to a blank tab.',
        message:
            'After evaluation, Continue Learning returns to a blank tab instead of Practice.',
        status: ComplaintStatus.pending,
        category: 'Conversation',
        categoryLabel: 'Conversation',
        submittedAt: DateTime(2026, 11, 7, 18, 8),
      ),
      ComplaintItem(
        id: 'C-1027',
        learnerName: 'Yara Mahmoud',
        learnerEmail: 'yara.mahmoud@university.edu',
        initials: 'YM',
        title: 'Filter chips overlap',
        description:
            'On Practice, level badge overlaps the first scenario card.',
        message:
            'On Practice, the level badge overlaps the first scenario card on iPhone SE.',
        status: ComplaintStatus.resolved,
        category: 'UI',
        categoryLabel: 'UI',
        submittedAt: DateTime(2026, 11, 7, 10, 14),
        adminReply: 'Spacing was adjusted for compact devices.',
      ),
      ComplaintItem(
        id: 'C-1026',
        learnerName: 'Chris Evans',
        learnerEmail: 'chris.evans@university.edu',
        initials: 'CE',
        title: 'Score update banner missing',
        description:
            'Admin adjusted my score but the green banner never appeared.',
        message:
            'Admin adjusted my score but the green banner never appeared on Results.',
        status: ComplaintStatus.inProgress,
        category: 'Weekly Test',
        categoryLabel: 'Quiz & scoring',
        submittedAt: DateTime(2026, 11, 6, 22, 1),
      ),
      ComplaintItem(
        id: 'C-1025',
        learnerName: 'Fatma Adel',
        learnerEmail: 'fatma.adel@university.edu',
        initials: 'FA',
        title: 'App crashes on send',
        description:
            'Sending a long reply in Restaurant scenario closes the app.',
        message:
            'Sending a long reply in Restaurant scenario closes the app immediately.',
        status: ComplaintStatus.pending,
        category: 'Conversation',
        categoryLabel: 'Conversation',
        submittedAt: DateTime(2026, 11, 6, 13, 40),
      ),
      ComplaintItem(
        id: 'C-1024',
        learnerName: 'Michael Trent',
        learnerEmail: 'michael.trent@university.edu',
        initials: 'MT',
        title: 'Resolved but still open',
        description:
            'Support marked this resolved while my quiz remains locked.',
        message:
            'Support marked this resolved while my quiz remains locked on Active.',
        status: ComplaintStatus.resolved,
        category: 'Weekly Test',
        categoryLabel: 'Quiz & scoring',
        submittedAt: DateTime(2026, 11, 5, 16, 25),
        adminReply: 'Unlock was applied. Please reopen Weekly Test.',
      ),
      ComplaintItem(
        id: 'C-1023',
        learnerName: 'Layla Hassan',
        learnerEmail: 'layla.hassan@university.edu',
        initials: 'LH',
        title: 'Search finds old results only',
        description:
            'Searching vocabulary never returns words saved this week.',
        message:
            'Searching vocabulary never returns words saved this week on my account.',
        status: ComplaintStatus.resolved,
        category: 'Vocabulary',
        categoryLabel: 'Vocabulary',
        submittedAt: DateTime(2026, 11, 5, 9, 12),
        adminReply: 'Search index was rebuilt for your saved words.',
      ),
    ];

    assert(items.length == 18, 'Mock seed must contain 18 complaints.');
    return items;
  }
}
