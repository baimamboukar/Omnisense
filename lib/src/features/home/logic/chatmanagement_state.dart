part of 'chatmanagement_cubit.dart';

@freezed
abstract class ChatmanagementState with _$ChatmanagementState {
  const factory ChatmanagementState.initial() = _Initial;
  const factory ChatmanagementState.loading() = _Loading;
  const factory ChatmanagementState.loaded({
    required List<OmnisenseChat> chats,
  }) = _Loaded;
  const factory ChatmanagementState.chatUpdating() = _ChatUpdating;
  const factory ChatmanagementState.chatUpdated() = _ChatUpdated;
  //const factory ChatmanagementState.chat() = _ChatUpdating;
  const factory ChatmanagementState.loadedChat({
    required OmnisenseChat chat,
  }) = _LoadedChat;
  const factory ChatmanagementState.chatCreated({
    required OmnisenseChat chat,
  }) = _ChatCreated;
  const factory ChatmanagementState.failed({required String failure}) = _Failed;
}
