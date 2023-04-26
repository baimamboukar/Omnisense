import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:lottie/lottie.dart';
import 'package:omnisense/src/app/assets.dart';
import 'package:omnisense/src/extensions/num.dart';
import 'package:omnisense/src/features/chat/chat.dart';
import 'package:omnisense/src/features/chat/data/models/omnisense_chat.dart';
import 'package:omnisense/src/features/chat/logic/chat_cubit.dart';
import 'package:omnisense/src/features/home/logic/chatmanagement_cubit.dart';
import 'package:quickalert/quickalert.dart';
import 'package:vibration/vibration.dart';

final promptController = TextEditingController();
final _scrollController = ScrollController();

@RoutePage(
  name: 'omnisenseChatRoom',
)
class OmnisenseChatRoom extends StatelessWidget with AutoRouteWrapper {
  const OmnisenseChatRoom({super.key, required this.chat});
  final OmnisenseChat chat;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint('WillPopScope');
        final updated =
            await BlocProvider.of<ChatmanagementCubit>(context).updateChat(
          chat: chat.copyWith(
            name: chat.messages.first.message.padLeft(12),
          ),
        );
        if (updated) {
          return true;
        } else {
          // ignore: use_build_context_synchronously
          await QuickAlert.show(
            context: context,
            title: 'Error',
            type: QuickAlertType.error,
            widget: const Text('Could not update chat'),
            onCancelBtnTap: () => Navigator.of(context).pop(),
          );
          return false;
        }
      },
      child: BlocListener<ChatCubit, ChatState>(
        listener: (context, state) {
          state.whenOrNull(
            initial: () {
              promptController.clear();
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent,
              );
            },
            completing: () {},
            completed: (chat, completion) {
              context.read<ChatCubit>().hydrate();
              promptController.clear();
              Timer(const Duration(milliseconds: 500), () {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              });

              Vibration.vibrate(
                pattern: [300, 200, 100],
                intensities: [1, 255],
              );
            },
            error: (error) async {
              await Vibration.vibrate(duration: 1000);
              // ignore: use_build_context_synchronously
              await QuickAlert.show(
                context: context,
                title: 'Omnisense Error',
                type: QuickAlertType.error,
                widget: Text('Could not get response, $error'),
                onCancelBtnTap: () => Navigator.of(context).pop(),
              );
            },
          );
        },
        child: Scaffold(
          body: Column(
            children: [
              34.vGap,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    const ImageIcon(
                      AssetImage(Assets.assetsImagesHappy),
                      size: 44,
                    ),
                    Builder(
                      builder: (context) {
                        final name = context.read<ChatCubit>().chat.name;
                        final chatName = name.length > 32
                            ? '${name.substring(0, 32)}...'
                            : name;
                        return Text(chatName);
                      },
                    ),
                    const Spacer(),
                    const Icon(Hicons.close, color: Colors.black),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        final chat = BlocProvider.of<ChatCubit>(context).chat;
                        return ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: chat.messages.length,
                          itemBuilder: (context, index) {
                            final message = chat.messages[index];
                            return ChatMessage(
                              data: message,
                            );
                          },
                        );
                      },
                      completed: (chat, completion) {
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: chat.messages.length,
                          itemBuilder: (context, index) {
                            final message = chat.messages[index];
                            return ChatMessage(
                              data: message,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const SizedBox();
                    },
                    completing: () => Padding(
                      padding: const EdgeInsets.only(bottom: 38),
                      child: Lottie.asset(
                        Assets.assetsAnimationsLoadingAnimation,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    error: (message) {
                      return Column(
                        children: [
                          Text(
                            message,
                            style: const TextStyle(color: Colors.red),
                          ),
                          8.vGap,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: promptController,
                                    onFieldSubmitted: (prompt) async {
                                      Timer(const Duration(milliseconds: 500),
                                          () {
                                        _scrollController.jumpTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                        );
                                      });
                                      await context
                                          .read<ChatCubit>()
                                          .completeChat(prompt);
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Type a message...',
                                      border: InputBorder.none,
                                      suffixIcon: GestureDetector(
                                        onTap: () async {
                                          Timer(
                                              const Duration(milliseconds: 500),
                                              () {
                                            _scrollController.jumpTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                            );
                                          });
                                          await context
                                              .read<ChatCubit>()
                                              .completeChat(
                                                promptController.text,
                                              );
                                        },
                                        child: const Icon(
                                          Hicons.send_2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    initial: () {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: promptController,
                                onFieldSubmitted: (prompt) async {
                                  Timer(const Duration(milliseconds: 500), () {
                                    _scrollController.jumpTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                    );
                                  });
                                  await context
                                      .read<ChatCubit>()
                                      .completeChat(prompt);
                                },
                                decoration: InputDecoration(
                                  hintText: 'Type a message...',
                                  border: InputBorder.none,
                                  suffixIcon: GestureDetector(
                                    onTap: () async {
                                      Timer(const Duration(milliseconds: 500),
                                          () {
                                        _scrollController.jumpTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                        );
                                      });
                                      await context
                                          .read<ChatCubit>()
                                          .completeChat(promptController.text);
                                    },
                                    child: const Icon(
                                      Hicons.send_2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    completed: (chat, completion) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: promptController,
                                onFieldSubmitted: (value) async {
                                  await context
                                      .read<ChatCubit>()
                                      .completeChat(value);
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Type a message...',
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Hicons.send_2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatCubit(chat: chat),
        ),
        BlocProvider(
          create: (context) => ChatmanagementCubit(),
        ),
      ],
      child: this,
    );
  }
}
