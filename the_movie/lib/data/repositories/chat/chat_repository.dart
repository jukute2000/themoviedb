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

  Stream<List<ChatRoom>?> getChatRooms();

  Future<bool> updateLastTimeChatRoom(String chatId, String Datetime);

  Future<ChatRoom?> createChatRoom(List<String> userId);

  Stream<LastMessage?> getLastMessage(String chatId);

  Future<LastMessage?> getLastMessagebyFuture(String chatId);

  Future<bool> createLastMessage(
    String chatId,
    String message,
    List<String> userState,
  );

  Future<bool> updateLastMessage(
      String chatId, String message, bool isSend, String dateTime);

  Stream<List<DetailChat>> getListDetailChat(String chatId);

  Future<bool> addDetailMessage(String chatId, String message);

  Future<bool> deleteDetailMessage(String chatId, String messageId);

  Future<bool> editDetailMessage(
      String chatId, String messageId, String message);
}

class ChatRepositoryImpl implements ChatRepository {
  static final ChatRepositoryImpl _instance = ChatRepositoryImpl._internal();

  ChatRepositoryImpl._internal();

  static ChatRepositoryImpl get instance => _instance;

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
  Stream<List<ChatRoom>> getChatRooms() {
    final docRef = FirebaseTmdbController.getInstance()
        .db
        .collection("listChat")
        .doc("chatIds");

    return docRef.snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return [];

      final List<dynamic> list = snapshot.data()!["list_chat"] ?? [];

      final chatRooms = list.map((e) => ChatRoom.fromJson(e)).where((room) {
        // Lọc ra các room mà user có tham gia
        return room.usersId?.contains(user!.uid) ?? false;
      }).toList();

      // Sắp xếp theo thời gian tin nhắn cuối (mới nhất lên trước)
      chatRooms.sort((a, b) {
        final aTime = DateTime.tryParse(a.lastMessageAt ?? '') ?? DateTime(0);
        final bTime = DateTime.tryParse(b.lastMessageAt ?? '') ?? DateTime(0);
        return bTime.compareTo(aTime);
      });

      return chatRooms;
    });
  }

  @override
  Future<bool> updateLastTimeChatRoom(String chatId, String datetime) async {
    try {
      print(datetime);
      final docRef = FirebaseTmdbController.getInstance()
          .db
          .collection("listChat")
          .doc("chatIds");

      final snapshot = await docRef.get();

      if (!snapshot.exists || snapshot.data() == null) return false;
      //
      final List<ChatRoom> chatRooms = List.from(snapshot.data()!['list_chat'])
          .map((e) => ChatRoom.fromJson(e))
          .toList();

      final index = chatRooms.indexWhere((element) => element.chatId == chatId);
      if (index == -1) return false;

      // Cập nhật thời gian mới
      chatRooms[index].lastMessageAt = datetime;

      // Ghi đè lại mảng
      final updatedList = chatRooms.map((e) => e.toJson()).toList();

      await docRef.set({'list_chat': updatedList}, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('updateLastTimeChatRoom error: $e');
      return false;
    }
  }

  @override
  Future<ChatRoom?> createChatRoom(List<String> userId) async {
    try {
      if (user == null) return null;
      Uuid uuid = const Uuid();
      final chatRoom = ChatRoom(
          chatId: uuid.v4(),
          createdAt: DateTime.now().toString(),
          lastMessageAt: DateTime.now().toString(),
          usersId: [user!.uid, ...userId]);
      await FirebaseTmdbController.getInstance()
          .db
          .collection("listChat")
          .doc("chatIds")
          .set({
        "list_chat": FieldValue.arrayUnion([chatRoom.toJson()])
      }, SetOptions(merge: true));
      await createLastMessage(chatRoom.chatId!, null, chatRoom.usersId!);
      return chatRoom;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Stream<LastMessage?> getLastMessage(String chatId) {
    final docRef = FirebaseTmdbController.getInstance()
        .db
        .collection("listLastMessage")
        .doc(chatId);

    return docRef.snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      return LastMessage.fromJson(snapshot.data()!);
    });
  }

  @override
  Future<LastMessage?> getLastMessagebyFuture(String chatId) async {
    try {
      final docRef = FirebaseTmdbController.getInstance()
          .db
          .collection("listLastMessage")
          .doc(chatId);
      final doc = await docRef.get();

      if (!doc.exists || doc.data() == null) return null;

      LastMessage lastMessage = LastMessage.fromJson(doc.data()!);
      return lastMessage;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> createLastMessage(
      String chatId, String? message, List<String> userState) async {
    try {
      if (user == null) return false;
      userState = userState;
      final lastMessage = LastMessage(
        message: message,
        seen: userState.map((e) => {"id": e, "unseen": 0}).toList(),
      );
      await FirebaseTmdbController.getInstance()
          .db
          .collection("listLastMessage")
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
      String chatId, String message, bool isSend, String datetime
      //phan nguoi gui va nguoi xem
      ) async {
    try {
      print(datetime);
      if (user == null) return false;
      LastMessage? lastMessage =
          await ChatRepositoryImpl._instance.getLastMessagebyFuture(chatId);
      if (isSend) lastMessage!.message = message;
      lastMessage!.seen?.forEach(
        (element) {
          if (isSend) {
            if (element["id"] != user!.uid) {
              element["unseen"] = element["unseen"] + 1;
            } else {
              element["unseen"] = 0;
            }
          } else {
            if (element["id"] == user!.uid) {
              element["unseen"] = 0;
            }
          }
        },
      );
      FirebaseTmdbController.getInstance()
          .db
          .collection("listLastMessage")
          .doc(chatId)
          .set(lastMessage.toJson(), SetOptions(merge: true));
      if (message.isNotEmpty || message != '' && isSend) {
        await updateLastTimeChatRoom(chatId, datetime);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Stream<List<DetailChat>> getListDetailChat(String chatId) {
    final docRef = FirebaseTmdbController.getInstance()
        .db
        .collection("listDetailChat")
        .doc(chatId);

    return docRef.snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return [];

      final data = snapshot.data()!;
      final List<DetailChat> listDetailChat = [];

      for (var element in data["list_chat"]) {
        final detailChat = DetailChat.fromJson(element);
        listDetailChat.add(detailChat);
      }

      listDetailChat.sort(
        (a, b) {
          final aTime= DateTime.tryParse(a.time ?? "");
          final bTime= DateTime.tryParse(b.time ?? "");

          if (aTime == null && bTime == null) {
            return 0;
          }
          if (aTime == null) return 1;
          if (bTime == null) return -1;
          return aTime.compareTo(bTime);
        }
      );

      return listDetailChat;
    });
  }

  @override
  Future<bool> addDetailMessage(String chatId, String message) async {
    try {
      if (user == null) return false;

      final detailChat = DetailChat(
        idSend: user!.uid,
        messageId: const Uuid().v4(),
        message: message,
        time: DateTime.now().toIso8601String(),
      );

      await FirebaseTmdbController.getInstance()
          .db
          .collection("listDetailChat")
          .doc(chatId)
          .set({
        "list_chat": FieldValue.arrayUnion([detailChat.toJson()])
      }, SetOptions(merge: true));

      await updateLastMessage(chatId, message, true, detailChat.time!);
      return true;
    } catch (e) {
      print("Error adding message: $e");
      return false;
    }
  }

  @override
  Future<bool> deleteDetailMessage(String chatId, String? messageId) async {
    try {
      if (user == null) return false;

      final doc = FirebaseTmdbController.getInstance()
          .db
          .collection("listDetailChat")
          .doc(chatId);

      final snapshot = await doc.get();
      if (!snapshot.exists || snapshot.data() == null) return false;

      final data = snapshot.data()!;
      final List<DetailChat> listChat = List.from(data["list_chat"])
          .map((e) => DetailChat.fromJson(e))
          .toList();

      ChatRoom? chatRoom = await getChatRoomById(chatId);
      // Lọc bỏ message có message_id trùng khớp
      final filteredList = listChat.where((item) {
        //tách ra thành hàm
        if (checkKeyLastMessage(
            item, checkStringNull(messageId), chatRoom!.lastMessageAt!)) {
          updateLastMessage(chatId, 'Tin nhắn đã bị xoá', true,
              DateTime.now().toIso8601String());
          return false; // xoá item này
        }
        return item.messageId != messageId;
      }).toList();

// Chuyển list về dạng List<Map<String, dynamic>>
      final updatedList = filteredList.map((e) => e.toJson()).toList();

// Cập nhật lại list_chat trong Firestore
      await doc.update({"list_chat": updatedList});

      return true;
    } catch (e) {
      print("Error deleting message: $e");
      return false;
    }
  }

  @override
  Future<bool> editDetailMessage(
      String chatId, String? messageId, String message) async {
    try {
      if (user == null ||
          chatId.isEmpty ||
          messageId == null ||
          messageId.isEmpty) {
        return false;
      }

      final doc = FirebaseTmdbController.getInstance()
          .db
          .collection("listDetailChat")
          .doc(chatId);

      final snapshot = await doc.get();
      if (!snapshot.exists || snapshot.data() == null) return false;

      final data = snapshot.data()!;
      final List<DetailChat> listChat = List.from(data["list_chat"])
          .map((e) => DetailChat.fromJson(e))
          .toList();
      // Lọc bỏ message có message_id trùng khớp
      ChatRoom? chatRoom = await getChatRoomById(chatId);
      final updatedList = listChat.map((item) {
        if (checkKeyLastMessage(
            item, checkStringNull(messageId), chatRoom!.lastMessageAt!)) {
          item.time = DateTime.now().toIso8601String();
          updateLastMessage(chatId, message, true, item.time!);
        }
        if (item.messageId == messageId && item.idSend == user!.uid) {
          item.message = message;
        }
        return item.toJson();
      }).toList();

      // Cập nhật lại list_chat đã lọc
      await doc.update({"list_chat": updatedList});
      return true;
    } catch (e) {
      print("Error deleting message: $e");
      return false;
    }
  }

  Future<ChatRoom?> getChatRoomById(String chatId) async {
    ChatRoom? chatRoom;
    final doc = await FirebaseTmdbController.getInstance()
        .db
        .collection("listChat")
        .doc("chatIds")
        .get();
    if (!doc.exists || doc.data() == null) return null;
    final listChat = List.from(doc.data()!["list_chat"]);
    chatRoom = listChat
        .map((e) => ChatRoom.fromJson(e))
        .firstWhere((room) => room.chatId == chatId);
    return chatRoom;
  }

  bool checkKeyLastMessage(
      DetailChat detailChat, String messageId, String lastMessageAt) {
    print(
        "${detailChat.messageId}- ${messageId}, ${detailChat.time}-$lastMessageAt");
    if (detailChat.messageId == messageId && detailChat.time == lastMessageAt) {
      return true;
    }
    return false;
  }

  String checkStringNull(String? string) {
    try {
      if (string!.isEmpty) return '';
      return string;
    } catch (e) {
      return '';
    }
  }
}
