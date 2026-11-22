import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_app_bar.dart';
import '../core/widgets/custom_dialog.dart';
import '../core/widgets/custom_text.dart';
import '../models/conversation_models.dart';
import '../models/scenario_models.dart';
import '../viewmodels/conversation_cubit.dart';
import '../viewmodels/conversation_state.dart';
import '../widgets/conversation_hint_card.dart';
import '../widgets/conversation_input_bar.dart';
import '../widgets/conversation_message_bubble.dart';
import '../widgets/conversation_status_row.dart';
import 'conversation_evaluation_view.dart';

/// AI Conversation screen (Figma node 6:77823).
class AiConversationView extends StatelessWidget {
  const AiConversationView({
    super.key,
    required this.scenario,
    this.levelLabel,
  });

  final ScenarioItem scenario;
  final String? levelLabel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ConversationCubit(scenario: scenario, levelLabel: levelLabel),
      child: const _AiConversationBody(),
    );
  }
}

class _AiConversationBody extends StatefulWidget {
  const _AiConversationBody();

  @override
  State<_AiConversationBody> createState() => _AiConversationBodyState();
}

class _AiConversationBodyState extends State<_AiConversationBody> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _send(BuildContext context) async {
    final raw = _inputController.text;
    final text = raw.trim();
    if (text.isEmpty) return;

    final cubit = context.read<ConversationCubit>();
    if (!cubit.state.canSend) return;

    final countBefore = cubit.state.messages.length;
    _inputController.clear();
    await cubit.sendMessage(text);
    if (!context.mounted) return;

    // Restore draft if the message was not accepted into the conversation.
    if (cubit.state.messages.length <= countBefore) {
      _inputController.text = raw;
      _inputController.selection = TextSelection.collapsed(offset: raw.length);
    }
    _scrollToBottom();
  }

  Future<void> _endAndEvaluate(BuildContext context) async {
    final cubit = context.read<ConversationCubit>();
    final result = await cubit.endAndEvaluate();
    if (!context.mounted || result == null) return;
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ConversationEvaluationView(
          evaluation: result,
          scenario: cubit.state.scenario,
          levelLabel: cubit.state.levelLabel,
        ),
      ),
    );
  }

  Future<void> _showMoreOptions(BuildContext context) async {
    final leave = await showModalBottomSheet<bool>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text(AppStrings.conversationLeave),
                onTap: () => Navigator.pop(sheetContext, true),
              ),
              ListTile(
                title: const Text(AppStrings.cancel),
                onTap: () => Navigator.pop(sheetContext, false),
              ),
            ],
          ),
        );
      },
    );
    if (leave == true && context.mounted) {
      final confirmed = await CustomDialog.showConfirm(
        context,
        title: AppStrings.conversationLeaveTitle,
        message: AppStrings.conversationLeaveMessage,
        confirmLabel: AppStrings.quizLeave,
        cancelLabel: AppStrings.quizStay,
      );
      if (confirmed == true && context.mounted) {
        Navigator.of(context).maybePop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConversationCubit, ConversationState>(
      listenWhen: (previous, current) =>
          previous.messages.length != current.messages.length ||
          previous.isAiTyping != current.isAiTyping ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        _scrollToBottom();
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<ConversationCubit>().clearError();
        }
      },
      builder: (context, state) {
        final isEvaluating = state.status == ConversationStatus.evaluating;
        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FC),
          appBar: CustomAppBar(
            title: state.profile.displayTitle,
            subtitle: state.profile.appBarSubtitle,
            centerTitle: false,
            backgroundColor: AppColors.white,
            titleStyle: AppTextStyles.pageTitle,
            subtitleStyle: AppTextStyles.pageSubtitle,
            height: AppDimensions.appBarHeightLg,
            leadingWidth: 56,
            titleSpacing: AppDimensions.spaceMd,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.of(context).maybePop(),
                  splashColor: AppColors.primary.withValues(alpha: 0.16),
                  highlightColor: AppColors.primaryLight.withValues(alpha: 0.7),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.arrowLeft,
                        width: AppDimensions.navIconSize,
                        height: AppDimensions.navIconSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => _showMoreOptions(context),
                    splashColor: AppColors.primary.withValues(alpha: 0.16),
                    highlightColor: AppColors.primaryLight.withValues(
                      alpha: 0.7,
                    ),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.moreHorizontal,
                          width: AppDimensions.navIconSize,
                          height: AppDimensions.navIconSize,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.screenPadding,
                AppDimensions.spaceMd,
                AppDimensions.screenPadding,
                AppDimensions.spaceMd,
              ),
              child: Column(
                children: [
                  ConversationStatusRow(
                    availability: state.partnerAvailability,
                    canEvaluate: state.canEvaluate,
                    isEvaluating: isEvaluating,
                    onEndAndEvaluate: () => _endAndEvaluate(context),
                  ),
                  const SizedBox(height: AppDimensions.spaceMd),
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount:
                          state.messages.length + (state.isAiTyping ? 1 : 0),
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: AppDimensions.spaceMd),
                      itemBuilder: (context, index) {
                        if (index >= state.messages.length) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              AppStrings.conversationTyping,
                              style: AppTextStyles.caption,
                            ),
                          );
                        }
                        return ConversationMessageBubble(
                          message: state.messages[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceMd),
                  ConversationHintCard(hint: state.currentHint),
                  const SizedBox(height: AppDimensions.spaceMd),
                  ConversationInputBar(
                    controller: _inputController,
                    enabled: state.canSend && !isEvaluating,
                    isBusy: state.isSending || state.isAiTyping,
                    onSend: (_) => _send(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
