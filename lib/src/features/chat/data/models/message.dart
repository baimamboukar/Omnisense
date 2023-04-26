// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageData {
  final String sender;
  final String message;
  final bool isMe;
  final String time;
  MessageData({
    required this.sender,
    required this.message,
    required this.isMe,
    required this.time,
  });

  MessageData copyWith({
    String? sender,
    String? message,
    bool? isMe,
    String? time,
  }) {
    return MessageData(
      sender: sender ?? this.sender,
      message: message ?? this.message,
      isMe: isMe ?? this.isMe,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'message': message,
      'isMe': isMe,
      'time': time,
    };
  }

  factory MessageData.fromMap(Map<String, dynamic> map) {
    return MessageData(
      sender: (map['sender'] ?? '') as String,
      message: (map['message'] ?? '') as String,
      isMe: (map['isMe'] ?? false) as bool,
      time: (map['time'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageData.fromJson(String source) =>
      MessageData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageData(sender: $sender, message: $message, isMe: $isMe, time: $time)';
  }

  @override
  bool operator ==(covariant MessageData other) {
    if (identical(this, other)) return true;

    return other.sender == sender &&
        other.message == message &&
        other.isMe == isMe &&
        other.time == time;
  }

  @override
  int get hashCode {
    return sender.hashCode ^ message.hashCode ^ isMe.hashCode ^ time.hashCode;
  }
}
