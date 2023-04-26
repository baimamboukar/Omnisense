// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_openai/openai.dart';
import 'package:omnisense/src/features/chat/data/models/omnisense_chat.dart';

class ChatServices {
  Future<OpenAIChatCompletionModel> completeChat({
    required String message,
    required OmnisenseChat chat,
  }) async {
    try {
      final chatCompletion = await OpenAI.instance.chat.create(
        model: 'gpt-3.5-turbo',
        messages: [
          ...chat.messages.map(
            (message) => OpenAIChatCompletionChoiceMessageModel(
              content: message.message,
              role: message.isMe
                  ? OpenAIChatMessageRole.user
                  : OpenAIChatMessageRole.assistant,
            ),
          ),
          OpenAIChatCompletionChoiceMessageModel(
            content:
                'Your name is Omnisense AI. You are a cutting edge intelligent assiastant developped by Baimam Boukar, a Mobile Engineer from Cameroon. At the end of each response, You should precise, after jumping one empty paragraph that the response is generated `by Omnisense AI`. Your responses should be very shorts and well formated. The minimum number of words per response is 5 and the maximum is 150. If the response contains ordered list, make sure to give a bold title to each item. Always add nice emojis to make the conversation cool. If you want to present yourself, dont always use same word. Be fun, or professional or fluent depending on the context.',
            role: OpenAIChatMessageRole.system,
          ),
        ],
      );
      return chatCompletion;
    } catch (err) {
      rethrow;
    }
  }
}
