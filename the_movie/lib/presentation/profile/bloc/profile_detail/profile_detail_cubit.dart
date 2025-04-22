import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/account/account_model.dart';
import 'package:the_movie/data/repositories/account_repository.dart';
import 'package:the_movie/data/repositories/auth_repository.dart';
import 'package:the_movie/presentation/profile/bloc/profile_detail/profile_detail_state.dart';

class ProfileDetailCubit extends Cubit<ProfileDetailState> {
  ProfileDetailCubit() : super(ProfileDetailInitial());
  bool _isLoading = false;

  void loadProfileDetails({bool isLoadMode = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    if (!isLoadMode) {
      if (!isClosed) emit(ProfileDetailIsLoading());
    }
    try {
      AccountModel accountmodel =
          await AccountRepositoryImpl.instance.getDetails();
      if (!isClosed) {
        emit(AccountProfileDetailLoaded(accountModel: accountmodel));
      }
    } catch (e) {
      if (!isClosed) emit(ProfileDetailError("Error: $e"));
    } finally {
      _isLoading = false;
    }
  }

  void logOut() async {
    await AuthRepositoryImpl.instance.logOut();
  }
}
