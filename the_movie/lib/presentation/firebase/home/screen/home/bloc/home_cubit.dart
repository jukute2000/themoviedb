import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/data/controller/fire_auth_controller.dart';
import 'package:the_movie/data/models/chat/auth.dart';
import 'package:the_movie/data/models/chat/chat_room.dart';
import 'package:the_movie/data/repositories/chat/chat_repository.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/bloc/home_state.dart';
import '../../../../detail/detail_chat_screen.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  User user = FireAuthController.getInstance().auth.currentUser!;
  void fetchData() async {
    emit(HomeLoading());
    try {
      final List<Authentication>? auths =
          await ChatRepositoryImpl.instance.getListUser();
      final List<ChatRoom>? chatRooms =
          await ChatRepositoryImpl.instance.getChatRoom();
      emit(HomeLoaded(chatRooms: chatRooms, auths: auths));
    } catch (e) {
      emit(HomeError('Failed to load data'));
    }
  }

  void createChatRoom(BuildContext context, List<String> users,
      List<ChatRoom>? chatRooms) async {
    ChatRoom? _chatRoom;
    try {
      bool isContain = false;
      //Kiểm tra xem người dùng đã có phòng chat chưa
      if (chatRooms == null) {
        isContain = true;
      } else {
        for (var chatRoom in chatRooms) {
          if (!const ListEquality()
              .equals(chatRoom.usersId, [user.uid, ...users])) {
            isContain = true;
          } else {
            isContain = false;
            _chatRoom = chatRoom;
            break;
          }
        }
      }
      if (isContain) {
        _chatRoom = await ChatRepositoryImpl.instance.createChatRoom(users);
      }
      AppNavigator.push(context, const DetailChatScreen());
      fetchData();
    } catch (e) {
      emit(HomeError('Failed to create chat room'));
    }
  }
}
