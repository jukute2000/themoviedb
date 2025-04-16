import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_movie/data/controller/fire_auth_controller.dart';
import 'package:the_movie/data/controller/firebase_tmdb_controller.dart';
import 'package:the_movie/data/models/chat/auth.dart';
import 'package:the_movie/data/models/chat/chat_room.dart';
import 'package:the_movie/data/models/chat/last_message.dart';
import 'package:uuid/uuid.dart';

import '../../models/chat/detail_chat.dart';

abstract class ChatRepository {
  Future<List<Authentication>?> getListUser();
  Future<List<ChatRoom>?> getChatRoom();
  Future<bool> createChatRoom(List<String> userId);
  Future<LastMessage?>? getLastMessage(String chatId);
  Future<bool> createLastMessage(
    String chatId,
    String message,
    List<String> userState,
  );
  Future<bool> updateLastMessage(
    String chatId,
    LastMessage lastMessage,
    String message,
    bool isSend,
  );
  Future<List<DetailChat>?> getListDetailChat(String chatId);
  Future<bool> addDetailMessage(String chatId, String idSend, String message);
}

class ChatRepositoryImpl implements ChatRepository {
  User? user = FireAuthController.getInstance().auth.currentUser;

  @override
  Future<List<Authentication>?> getListUser() async {
    try {
      if (user == null) return null;
      final snapshot = await FirebaseTmdbController.getInstance()
          .db
          .collection("listUser")
          .doc("list_user")
          .get();

      if (!snapshot.exists || snapshot.data() == null) return null;

      List<Authentication>? listUser = [];

      for (var element in snapshot.data()!["list_users"]) {
        final author = Authentication.fromJson(element);
        if (author.id != user!.uid) {
          listUser.add(author);
        }
      }
      return listUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<ChatRoom>?> getChatRoom() async {
    try {
      if (user == null) return null;

      final snapshot = await FirebaseTmdbController.getInstance()
          .db
          .collection("listChat")
          .doc("chatIds")
          .get();

      if (!snapshot.exists || snapshot.data() == null) return null;

      List<ChatRoom>? listChatRoom = [];

      for (var element in snapshot.data()!["list_chat"]) {
        final chatRoom = ChatRoom.fromJson(element);
        if (chatRoom.usersId?.contains(user!.uid) ?? false) {
          listChatRoom.add(chatRoom);
        }
      }
      return listChatRoom;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<bool> createChatRoom(List<String> userId) async {
    try {
      if (user == null) return false;
      Uuid uuid = const Uuid();
      final chatRoom = ChatRoom(
          chatId: uuid.v4(),
          createdAt: DateTime.now().toString(),
          usersId: [user!.uid, ...userId]);
      await FirebaseTmdbController.getInstance()
          .db
          .collection("listChat")
          .doc("chatIds")
          .set({
        "list_chat": FieldValue.arrayUnion([chatRoom.toJson()])
      }, SetOptions(merge: true)).then(
        (value) async {
          await createLastMessage(chatRoom.chatId!, null, chatRoom.usersId!);
          return true;
        },
      );
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<LastMessage?>? getLastMessage(String chatId) async {
    try {
      if (user == null) return null;
      final snapshot = await FirebaseTmdbController.getInstance()
          .db
          .collection("listLasMessage")
          .doc(chatId)
          .get();

      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }

      final lastMessage = LastMessage.fromJson(snapshot.data()!);
      return lastMessage;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<bool> createLastMessage(
      String chatId, String? message, List<String> userState) async {
    try {
      if (user == null) return false;
      final lastMessage = LastMessage(
        message: message,
        seen: userState.map((e) => {"id": e, "unseen": 0}).toList(),
      );
      await FirebaseTmdbController.getInstance()
          .db
          .collection("listLasMessage")
          .doc(chatId)
          .set(lastMessage.toJson())
          .then(
        (value) {
          return true;
        },
      );
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> updateLastMessage(
    String chatId,
    LastMessage lastMessage,
    String message,
    bool isSend, //phan nguoi gui va nguoi xem
  ) async {
    try {
      if (user == null) return false;
      if (isSend) lastMessage.message = message;
      lastMessage.seen?.forEach(
        (element) {
          if (isSend) {
            if (element["id"] != user!.uid) {
              element["unseen"] = element["unseen"] + 1;
            }
          } else {
            if (element["id"] == user!.uid) {
              element["unseen"] = element["unseen"] - 1;
            }
          }
        },
      );
      FirebaseTmdbController.getInstance()
          .db
          .collection("listLasMessage")
          .doc(chatId)
          .set(lastMessage.toJson(), SetOptions(merge: true));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<DetailChat>?> getListDetailChat(String chatId) async {
    try {
      if (user == null) return null;
      final snapshot = await FirebaseTmdbController.getInstance()
          .db
          .collection("listDetailChat")
          .doc(chatId)
          .get();
      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }
      List<DetailChat>? listDetailChat = [];
      for (var element in snapshot.data()!["list_chat"]) {
        final detailChat = DetailChat.fromJson(element);
        listDetailChat.add(detailChat);
      }
      return listDetailChat;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> addDetailMessage(
      String chatId, String idSend, String message) async {
    try {
      if (user == null) return false;
      final detailChat = DetailChat(
        idSend: idSend,
        messageId: const Uuid().v4(),
        meesage: message,
        time: DateTime.now().toString(),
      );
      FirebaseTmdbController.getInstance()
          .db
          .collection("listDetailMessage")
          .doc(chatId)
          .set(detailChat.toJson(), SetOptions(merge: true));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
