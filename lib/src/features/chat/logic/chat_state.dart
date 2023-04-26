part of 'chat_cubit.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState.initial() = _Initial;
  const factory ChatState.completing() = _Completing;
  const factory ChatState.completed({
    required OmnisenseChat chat,
    required String completion,
  }) = _Completed;
  const factory ChatState.error(String message) = _Error;
}
