import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:omnisense/src/features/chat/chat.dart';
import 'package:omnisense/src/features/chat/data/models/omnisense_chat.dart';
import 'package:omnisense/src/features/chat/data/services/chat_services.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

class ChatCubit extends HydratedCubit<ChatState> {
  ChatCubit({required this.chat}) : super(const ChatState.initial());
  final OmnisenseChat chat;

  final service = ChatServices();
  Future<void> completeChat(String message) async {
    chat.messages.add(
      MessageData(
        sender: 'me',
        isMe: true,
        message: message,
        time: '${DateTime.now().microsecondsSinceEpoch}',
      ),
    );
    emit(const ChatState.completing());
    try {
      final response = await service.completeChat(message: message, chat: chat);
      final messageData = MessageData(
        sender: 'Omnisense AI',
        isMe: false,
        message: response.choices.first.message.content,
        time: DateTime.now().toString(),
      );
      chat.messages.add(messageData);
      emit(
        ChatState.completed(
          chat: chat,
          completion: response.choices.first.message.content,
        ),
      );
    } catch (err) {
      emit(ChatState.error(err.toString()));
    }
  }

  @override
  ChatState? fromJson(Map<String, dynamic> json) {
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ChatState state) {
    return null;
  }
}
