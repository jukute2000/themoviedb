import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/data/models/people/people_detail.dart';
import 'package:the_movie/data/repositories/people_repository.dart';
import 'package:the_movie/presentation/detail_cast/bloc/detail_cast/detail_cast._state.dart';

class DetailCastCubit extends Cubit<DetailCastState> {
  DetailCastCubit() : super(DetailCastInitial());

  void loadDetailCast(int id) async {
    emit(DetailCastIsLoading());
    try {
      final PeopleDetail peopleDetail =
          await PeopleRepositoryImpl.intance.getPeopleDetail(id: id);
      emit(DetailCastLoaded(detailPeople: peopleDetail));
    } catch (e) {
      emit(DetailCastError("Error: $e"));
    }
  }
}
