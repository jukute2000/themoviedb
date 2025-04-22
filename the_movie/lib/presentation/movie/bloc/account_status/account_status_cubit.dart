import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/account/account_status.dart';
import 'package:the_movie/data/repositories/account_repository.dart';
import 'package:the_movie/data/repositories/media_detail_repository.dart';
import 'package:the_movie/presentation/movie/bloc/account_status/account_status_state.dart';

class AccountStatusCubit extends Cubit<AccountStatusState> {
  AccountStatusCubit() : super(AccountStatusInitial());

  void loadAccountStatus(int id, bool isMovie) async {
    if (!isClosed) emit(AccountStatusIsLoading());
    try {
      AccountStatus accountStatus = await MediaDetailRepositoryImpl.instance
          .getAccountStatus(id: id, isMovie: isMovie);
      if (!isClosed) emit(AccountStatusLoaded(accountStatus: accountStatus));
    } catch (e) {
      if (!isClosed) emit(AccountStatusError("Error: $e"));
    }
  }

  void rateMovie(int id, double rateMedia, bool isMovie) async {
    await MediaDetailRepositoryImpl.instance
        .rateMovie(id: id, rateMedia: rateMedia, isMovie: isMovie);
  }

  void deleteRate(int id, bool isMovie) async {
    await MediaDetailRepositoryImpl.instance
        .deleteRate(id: id, isMovie: isMovie);
  }

  void addToFavorites(int id, bool isMovie, bool isFavorites) async {
    await AccountRepositoryImpl.instance
        .addToFavorites(id, isMovie, isFavorites);
  }

  void addToWatchList(int id, bool isMovie, bool isWatchList) async {
    await AccountRepositoryImpl.instance
        .addToWatchList(id, isMovie, isWatchList);
  }
}
