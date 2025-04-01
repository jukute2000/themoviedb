import 'package:the_movie/data/models/account/account_status.dart';

abstract class AccountStatusState {}

class AccountStatusInitial extends AccountStatusState {}

class AccountStatusIsLoading extends AccountStatusState {}

class AccountStatusLoaded extends AccountStatusState {
  final AccountStatus accountStatus;
  AccountStatusLoaded({required this.accountStatus});
}

class AccountStatusError extends AccountStatusState {
  final String message;
  AccountStatusError(this.message);
}
