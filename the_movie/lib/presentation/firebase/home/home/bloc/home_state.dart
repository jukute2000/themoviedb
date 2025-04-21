import 'package:the_movie/data/models/chat/auth.dart';
import 'package:the_movie/data/models/chat/chat_room.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ChatRoom>? chatRooms;
  final List<Authentication>? auths;
  HomeLoaded({required this.chatRooms, required this.auths});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
