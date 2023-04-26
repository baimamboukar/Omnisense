import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omnisense/src/features/chat/data/models/omnisense_chat.dart';

class ChatManagementService {
  final CollectionReference _chatsCollection =
      FirebaseFirestore.instance.collection('chats');
  final userID = FirebaseAuth.instance.currentUser!.uid;
  Future<OmnisenseChat> getChat(String chatId) async {
    try {
      final docSnapshot = await _chatsCollection.doc(chatId).get();
      if (docSnapshot.exists) {
        return OmnisenseChat.fromJson(
          // ignore: cast_nullable_to_non_nullable
          (docSnapshot.data() as Map<String, dynamic>).toString(),
        );
      } else {
        throw Exception('Chat does not exist');
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<List<OmnisenseChat>> getAllChats() async {
    try {
      final querySnapshot =
          await _chatsCollection.doc(userID).collection('chats').get();
      final documentSnapshots = querySnapshot.docs;
      final chats = documentSnapshots
          .map(
            (docSnapshot) => OmnisenseChat.fromMap(
              // ignore: cast_nullable_to_non_nullable
              docSnapshot.data(),
            ),
          )
          .toList();
      return chats;
    } catch (err) {
      debugPrint('$err');
      rethrow;
    }
  }

  Future<bool> createChat({required OmnisenseChat chat}) async {
    try {
      await _chatsCollection
          .doc(userID)
          .collection('chats')
          .doc(chat.id)
          .set(chat.toMap());
      return true;
    } catch (err) {
      debugPrint('$err');
      return false;
    }
  }

  Future<bool> deleteChat(String chatId) async {
    try {
      await _chatsCollection
          .doc(userID)
          .collection('chats')
          .doc(chatId)
          .delete();
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateChat({
    required String chatId,
    required OmnisenseChat chat,
  }) async {
    try {
      await _chatsCollection
          .doc(userID)
          .collection('chats')
          .doc(chatId)
          .update(chat.toMap());
      return true;
    } catch (err) {
      debugPrint('$err');
      return false;
    }
  }
}
