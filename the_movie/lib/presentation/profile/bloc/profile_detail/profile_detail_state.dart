import 'package:the_movie/data/models/account/account_model.dart';

abstract class ProfileDetailState {}

class ProfileDetailInitial extends ProfileDetailState {}

class ProfileDetailIsLoading extends ProfileDetailState {}

class AccountProfileDetailLoaded extends ProfileDetailState {
  final AccountModel accountModel;
  AccountProfileDetailLoaded({required this.accountModel});
}

class ProfileDetailError extends ProfileDetailState {
  final String message;
  ProfileDetailError(this.message);
}
