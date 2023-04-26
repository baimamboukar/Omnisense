// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OmnisenseUser {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String? profileImageURL;
  final bool isPrenium;
  OmnisenseUser({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImageURL,
    required this.isPrenium,
  });

  OmnisenseUser copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImageURL,
    bool? isPrenium,
  }) {
    return OmnisenseUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImageURL: profileImageURL ?? this.profileImageURL,
      isPrenium: isPrenium ?? this.isPrenium,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageURL': profileImageURL,
      'isPrenium': isPrenium,
    };
  }

  factory OmnisenseUser.fromMap(Map<String, dynamic> map) {
    return OmnisenseUser(
      id: map['id'] as String,
      name: (map['name'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
      profileImageURL: map['profileImageURL'] as String,
      isPrenium: (map['isPrenium'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OmnisenseUser.fromJson(String source) =>
      OmnisenseUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'OmnisenseUser(id: $id, name: $name, email: $email, phone: $phone, profileImageURL: $profileImageURL, isPrenium: $isPrenium)';
  }
}
