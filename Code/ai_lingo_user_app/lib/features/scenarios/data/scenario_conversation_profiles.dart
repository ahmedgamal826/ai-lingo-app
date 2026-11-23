import '../models/conversation_models.dart';
import '../models/scenario_models.dart';

/// Scenario-linked conversation scripts used by the mock AI partner.
class ScenarioConversationProfiles {
  ScenarioConversationProfiles._();

  static ScenarioConversationProfile forScenario(ScenarioItem scenario) {
    final key = scenario.title.toLowerCase();
    return _profiles[key] ??
        ScenarioConversationProfile(
          scenarioKey: key,
          displayTitle: scenario.title,
          categoryLabel: scenario.title,
          levelLabel: 'B1 Intermediate',
          partnerRole: 'a helpful English conversation partner',
          openingMessage:
              'Hi! Ready to practice "${scenario.title}"? How would you like to start?',
          hints: const [
            "Hint: Try a polite opening like 'Could you help me with...?'",
          ],
          replyBank: const [
            'That sounds good. Could you tell me a bit more?',
            'Nice! What would you like to do next?',
            'I understand. How can I help you further?',
          ],
          suggestedPhrases: const [
            'Could you help me, please?',
            'What do you recommend?',
          ],
          coachingCorrection: const GrammarCorrection(
            badgeLabel: 'GRAMMAR · CLARITY',
            originalText: 'I go there yesterday.',
            correctedText: 'I went there yesterday.',
            explanation:
                'Use the past simple for finished actions in the past.',
          ),
        );
  }

  static const Map<String, ScenarioConversationProfile> _profiles = {
    'restaurant': ScenarioConversationProfile(
      scenarioKey: 'restaurant',
      displayTitle: 'At a restaurant',
      categoryLabel: 'Restaurant',
      levelLabel: 'B1 Intermediate',
      partnerRole: 'a friendly restaurant host at Olive & Thyme',
      openingMessage:
          'Welcome to Olive & Thyme! Do you have a reservation, or would you like a table for tonight?',
      hints: [
        "Hint: 'What would you recommend?' is another natural way to ask.",
        "Hint: Try 'Could I see the menu, please?'",
        "Hint: 'I'd like a table for two, please.' sounds natural.",
      ],
      replyBank: [
        'Perfect. Right this way. Would you prefer a window seat or a quiet corner?',
        'Of course! Our specials tonight are grilled salmon and mushroom risotto. What sounds good?',
        'Great choice. Would you like anything to drink while you decide?',
        'Absolutely. I can also note any allergies. Shall I take your order?',
        'Coming right up. Is there anything else I can get for you?',
      ],
      suggestedPhrases: [
        'Could I have the bill, please?',
        'Does this dish contain any nuts?',
      ],
      coachingCorrection: GrammarCorrection(
        badgeLabel: 'GRAMMAR · VERB FORM',
        originalText: 'I would like order the pasta.',
        correctedText: 'I would like to order the pasta.',
        explanation: 'Use "would like to" before an action verb.',
      ),
    ),
    'job interview': ScenarioConversationProfile(
      scenarioKey: 'job interview',
      displayTitle: 'Job interview',
      categoryLabel: 'Career',
      levelLabel: 'B1 Intermediate',
      partnerRole: 'a professional interviewer',
      openingMessage:
          "Thanks for coming in today. Could you start by telling me a little about yourself?",
      hints: [
        "Hint: Use 'I have experience with...' to highlight your skills.",
        "Hint: 'One example is when I...' works well for stories.",
      ],
      replyBank: [
        'Interesting. Can you share a challenge you handled recently?',
        'That sounds relevant. Why are you interested in this role?',
        'Good answer. How do you usually work in a team?',
        'Thanks. Do you have any questions for me?',
      ],
      suggestedPhrases: [
        'I am excited about this opportunity because...',
        'In my previous role, I was responsible for...',
      ],
      coachingCorrection: GrammarCorrection(
        badgeLabel: 'GRAMMAR · TENSE',
        originalText: 'I work there for two years.',
        correctedText: 'I have worked there for two years.',
        explanation:
            'Use the present perfect for experience that continues to now.',
      ),
    ),
    'travel': ScenarioConversationProfile(
      scenarioKey: 'travel',
      displayTitle: 'Travel',
      categoryLabel: 'Travel',
      levelLabel: 'B1 Intermediate',
      partnerRole: 'a helpful hotel receptionist',
      openingMessage:
          'Welcome! Are you checking in today, or do you need help with directions?',
      hints: [
        "Hint: 'Could you recommend a place nearby?' is polite and clear.",
      ],
      replyBank: [
        'Sure. Your room is ready. Do you need an early checkout tomorrow?',
        'The city center is ten minutes by bus. Would you like a map?',
        'Of course. Breakfast is served from 7 to 10. Anything else I can help with?',
      ],
      suggestedPhrases: [
        'Where is the nearest metro station?',
        'Could I get a late checkout, please?',
      ],
      coachingCorrection: GrammarCorrection(
        badgeLabel: 'GRAMMAR · PREPOSITION',
        originalText: 'I arrive to the hotel at 3.',
        correctedText: 'I arrive at the hotel at 3.',
        explanation: 'Use "arrive at" for buildings and places.',
      ),
    ),
    'shopping': ScenarioConversationProfile(
      scenarioKey: 'shopping',
      displayTitle: 'Shopping',
      categoryLabel: 'Shopping',
      levelLabel: 'B1 Intermediate',
      partnerRole: 'a helpful store assistant',
      openingMessage:
          'Hi there! Are you looking for anything in particular today?',
      hints: ["Hint: Try 'Do you have this in a different size?'"],
      replyBank: [
        'Yes, we have that in blue and black. Which would you prefer?',
        'Great choice. Would you like to try it on?',
        'I can check the stockroom. One moment, please.',
      ],
      suggestedPhrases: [
        'How much does this cost?',
        'Do you accept card payments?',
      ],
      coachingCorrection: GrammarCorrection(
        badgeLabel: 'VOCABULARY · POLITENESS',
        originalText: 'Give me this one.',
        correctedText: 'Could I have this one, please?',
        explanation: 'A polite request sounds more natural in shops.',
      ),
    ),
    'daily conversations': ScenarioConversationProfile(
      scenarioKey: 'daily conversations',
      displayTitle: 'Daily conversations',
      categoryLabel: 'Everyday',
      levelLabel: 'B1 Intermediate',
      partnerRole: 'a friendly neighbor',
      openingMessage: 'Hey! Nice to see you. How has your week been so far?',
      hints: ["Hint: Follow up with 'What about you?' to keep the chat going."],
      replyBank: [
        'That sounds busy! Did you get any time to relax?',
        'Nice. I tried a new café nearby. Have you been there?',
        'I know the feeling. Want to grab coffee this weekend?',
      ],
      suggestedPhrases: [
        'How was your weekend?',
        'That sounds interesting. Tell me more.',
      ],
      coachingCorrection: GrammarCorrection(
        badgeLabel: 'GRAMMAR · QUESTION FORM',
        originalText: 'How you are today?',
        correctedText: 'How are you today?',
        explanation: 'Invert the subject and verb in questions.',
      ),
    ),
    'meeting new people': ScenarioConversationProfile(
      scenarioKey: 'meeting new people',
      displayTitle: 'Meeting new people',
      categoryLabel: 'Social',
      levelLabel: 'B1 Intermediate',
      partnerRole: 'a friendly guest at a networking event',
      openingMessage:
          "Hi! I don't think we've met. I'm Sam. What brings you here today?",
      hints: ["Hint: 'It's nice to meet you' is a natural next step."],
      replyBank: [
        'Nice to meet you too. What do you usually do for work?',
        'Cool! How did you get interested in that?',
        'We should exchange contacts. Do you use LinkedIn?',
      ],
      suggestedPhrases: [
        "It's great to meet you.",
        'What do you enjoy doing in your free time?',
      ],
      coachingCorrection: GrammarCorrection(
        badgeLabel: 'VOCABULARY · INTRODUCTIONS',
        originalText: 'Nice meet you.',
        correctedText: "Nice to meet you.",
        explanation: 'Use "Nice to meet you" when introducing yourself.',
      ),
    ),
  };
}
