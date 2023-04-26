import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:omnisense/src/features/chat/data/models/omnisense_chat.dart';
import 'package:omnisense/src/features/home/data/services/chat_management_service.dart';

part 'chatmanagement_state.dart';
part 'chatmanagement_cubit.freezed.dart';

class ChatmanagementCubit extends Cubit<ChatmanagementState> {
  ChatmanagementCubit() : super(const ChatmanagementState.initial());
  List<OmnisenseChat> chats = <OmnisenseChat>[];
  Future<bool> createChat({required OmnisenseChat chat}) async {
    final service = ChatManagementService();
    try {
      emit(const ChatmanagementState.loading());
      final created = await service.createChat(chat: chat);
      if (created) {
        chats.add(chat);
        emit(ChatmanagementState.chatCreated(chat: chat));
      } else {
        emit(
          const ChatmanagementState.failed(failure: 'Failed to create chat'),
        );
      }
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<List<OmnisenseChat>> getChats() async {
    final service = ChatManagementService();
    try {
      emit(const ChatmanagementState.loading());
      try {
        final loadedChats = await service.getAllChats();
        chats = loadedChats;
        emit(ChatmanagementState.loaded(chats: loadedChats));
      } catch (err) {
        emit(ChatmanagementState.failed(failure: err.toString()));
      }

      return chats;
    } catch (err) {
      return [];
    }
  }

  Future<OmnisenseChat> getChat(String chatId) async {
    final service = ChatManagementService();

    emit(const ChatmanagementState.loading());
    try {
      final chat = await service.getChat(chatId);
      emit(ChatmanagementState.loadedChat(chat: chat));
      return chat;
    } catch (err) {
      emit(ChatmanagementState.failed(failure: err.toString()));
      rethrow;
    }
  }

  Future<bool> deleteChat(String chatId) async {
    final service = ChatManagementService();
    try {
      emit(const ChatmanagementState.loading());
      final deleted = await service.deleteChat(chatId);
      if (deleted) {
        chats.removeWhere((element) => element.id == chatId);
        emit(ChatmanagementState.loaded(chats: chats));
      } else {
        emit(
          const ChatmanagementState.failed(failure: 'Failed to delete chat'),
        );
      }
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateChat({
    required OmnisenseChat chat,
  }) async {
    final service = ChatManagementService();
    try {
      emit(const ChatmanagementState.chatUpdating());
      final updated = await service.updateChat(chat: chat, chatId: chat.id);
      if (updated) {
        chats
          ..removeWhere((element) => element.id == chat.id)
          ..add(chat);
        emit(const ChatmanagementState.chatUpdated());
      } else {
        emit(
          const ChatmanagementState.failed(failure: 'Failed to update chat'),
        );
      }
      return true;
    } catch (err) {
      return false;
    }
  }
}
