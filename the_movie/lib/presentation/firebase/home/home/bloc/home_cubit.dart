import 'dart:async';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/controller/fire_auth_controller.dart';
import 'package:the_movie/data/models/chat/auth.dart';
import 'package:the_movie/data/models/chat/chat_room.dart';
import 'package:the_movie/data/repositories/chat/chat_repository.dart';
import 'package:the_movie/presentation/firebase/home/home/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  User user = FireAuthController.getInstance().auth.currentUser!;
  StreamSubscription<List<ChatRoom>>? chatRoomSubscription;

  @override
  Future<void> close() {
    chatRoomSubscription?.cancel();
    return super.close();
  }

  void fetchData() async {
    if (!isClosed) emit(HomeLoading());
    try {
      final List<Authentication>? auths =
          await ChatRepositoryImpl.instance.getListUser();
      chatRoomSubscription = ChatRepositoryImpl.instance.getChatRooms().listen(
        (chatRooms) {
          if (!isClosed) emit(HomeLoaded(chatRooms: chatRooms, auths: auths));
        },
      );
    } catch (e) {
      if (!isClosed) emit(HomeError('Failed to load data'));
    }
  }

  Future<ChatRoom> createChatRoom(
      List<String> users, List<ChatRoom>? chatRooms) async {
    ChatRoom? chatRoomTmp;
    try {
      bool isContain = false;
      //Kiểm tra xem người dùng đã có phòng chat chưa
      if (chatRooms == null || chatRooms.isEmpty) {
        isContain = true;
      } else {
        for (var chatRoom in chatRooms) {
          if (!const UnorderedIterableEquality()
              .equals(chatRoom.usersId, [...users, user.uid])) {
            isContain = true;
          } else {
            isContain = false;
            chatRoomTmp = chatRoom;
            break;
          }
        }
      }
      if (isContain) {
        //Nếu chưa có phòng chat thì tạo mới
        chatRoomTmp = await ChatRepositoryImpl.instance.createChatRoom(users);
      }
      fetchData();
      return chatRoomTmp!; //Lấy lại dữ liệu sau khi tạo phòng chat
    } catch (e) {
      if (!isClosed) emit(HomeError('Failed to create chat room'));
      rethrow; // Re-throw the exception to ensure the method doesn't complete normally
    }
  }

  List<String> nameChatRoom(ChatRoom chatRoom, List<Authentication> auths) {
    // Hàm này dùng để lấy tên của phòng chat
    String nameChatRoom = '';
    String name = '';
    for (var userId in chatRoom.usersId!) {
      final auth = auths.firstWhereOrNull(
          (auth) => auth.id == userId); //lấy ra auth của user id
      if (auth != null) {
        nameChatRoom += auth.firstCharName();
        name += '${auth.name} ';
      }
    }
    return [nameChatRoom, name];
  }

  String checkNameUser(String? name) {
    if (name == null || name.isEmpty) return "Unknow";
    return name;
  }
}
