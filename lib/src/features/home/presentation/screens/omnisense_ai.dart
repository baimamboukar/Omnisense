import 'package:auto_route/auto_route.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:omnisense/src/app/assets.dart';
import 'package:omnisense/src/extensions/auth_cubit.dart';
import 'package:omnisense/src/extensions/build_context.dart';
import 'package:omnisense/src/extensions/num.dart';
import 'package:omnisense/src/features/chat/data/models/omnisense_chat.dart';
import 'package:omnisense/src/features/home/logic/chatmanagement_cubit.dart';
import 'package:omnisense/src/router/router.gr.dart' as routes;

@RoutePage(
  name: 'omnisenseAI',
)
class OmnisenseAI extends StatelessWidget with AutoRouteWrapper {
  const OmnisenseAI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatmanagementCubit, ChatmanagementState>(
      listener: (context, state) {
        state.whenOrNull(
          initial: () async {
            await context.read<ChatmanagementCubit>().getChats();
          },
          loading: () {},
          chatCreated: (chat) {
            context.router.push(
              routes.OmnisenseChatRoom(
                chat: chat,
              ),
            );
          },
          failed: (error) {},
        );
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                34.vGap,
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage('${context.user!.profileImageURL}'),
                    ),
                    4.hGap,
                    Text(
                      'Hey, ${context.user!.name.split(" ").first.toLowerCase().capitalize}',
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Hicons.setting,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                14.vGap,
                GestureDetector(
                  onTap: () {
                    final chat = OmnisenseChat(
                      id: '${DateTime.now().millisecondsSinceEpoch}',
                      messages: [],
                      room: 'all',
                      name: 'Omnisense AI',
                    );

                    context.read<ChatmanagementCubit>().createChat(chat: chat);
                  },
                  child: Container(
                    width: context.width,
                    height: 50,
                    decoration: BoxDecoration(
                      // color: context.colorScheme.primary,
                      border: Border.all(color: context.colorScheme.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage(Assets.assetsImagesHappy),
                              color: context.colorScheme.primary,
                            ),
                            4.hGap,
                            Text(
                              'Start new chat',
                              style: context.bodyMd
                                  .copyWith(color: context.colorScheme.primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                14.vGap,
                Row(
                  children: [
                    Text(
                      'Recent Chats',
                      style: context.bodyLg,
                    ),
                  ],
                ),
                8.vGap,
                BlocBuilder<ChatmanagementCubit, ChatmanagementState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => Center(
                        child: TextButton(
                          onPressed: () {
                            context.read<ChatmanagementCubit>().getChats();
                          },
                          child: const Text('Refresh chats'),
                        ),
                      ),
                      failed: (error) => Center(
                        child: Text(error),
                      ),
                      loading: () => const Center(
                        child: RefreshProgressIndicator(),
                      ),
                      loaded: (chats) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            await context
                                .read<ChatmanagementCubit>()
                                .getChats();
                          },
                          child: ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: chats.length,
                            itemBuilder: (context, index) {
                              final chat = chats[index];
                              return GestureDetector(
                                onTap: () => context.router.push(
                                  routes.OmnisenseChatRoom(
                                    chat: chat,
                                  ),
                                ),
                                child: Slidable(
                                  key: ValueKey<String>(chat.id),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          context
                                              .read<ChatmanagementCubit>()
                                              .deleteChat(chat.id);
                                        },
                                        backgroundColor:
                                            context.colorScheme.tertiary,
                                        foregroundColor: Colors.white,
                                        icon: Hicons.delete_1,
                                        label: 'Delete',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {},
                                        backgroundColor:
                                            context.colorScheme.primary,
                                        foregroundColor: Colors.white,
                                        icon: Hicons.activity_1,
                                        label: 'Save',
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    leading: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: context.colorScheme.primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ImageIcon(
                                        const AssetImage(
                                          Assets.assetsImagesHappy,
                                        ),
                                        color: context.colorScheme.onPrimary,
                                      ),
                                    ),
                                    title: Text(chat.name),
                                    //subtitle: Text(chat.id),
                                  ),
                                ),
                              );
                            },
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
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return ChatmanagementCubit()..getChats();
          },
        ),
      ],
      child: this,
    );
  }
}
