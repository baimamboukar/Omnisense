// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:omnisense/src/features/chat/chat.dart';

class OmnisenseChat {
  final String id;
  final List<MessageData> messages;
  final String room;
  final String name;
  OmnisenseChat({
    required this.id,
    required this.messages,
    required this.room,
    required this.name,
  });

  OmnisenseChat copyWith({
    String? id,
    List<MessageData>? messages,
    String? room,
    String? name,
  }) {
    return OmnisenseChat(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      room: room ?? this.room,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'messages': messages.map((x) => x.toMap()).toList(),
      'room': room,
      'name': name,
    };
  }

  factory OmnisenseChat.fromMap(Map<String, dynamic> map) {
    return OmnisenseChat(
      id: (map['id'] ?? '') as String,
      messages: (map['messages'] as List<dynamic>?)
              ?.map((x) => MessageData.fromMap(x as Map<String, dynamic>))
              .toList() ??
          [],
      room: (map['room'] ?? '') as String,
      name: (map['name'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OmnisenseChat.fromJson(String source) =>
      OmnisenseChat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'OmnisenseChat(id: $id, messages: $messages, room: $room, name: $name)';
  }
}
