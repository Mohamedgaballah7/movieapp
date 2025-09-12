import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/ui/home/tabs/profile/watch_list/cubit/watch_list_states.dart';

class WatchListViewModel extends Cubit<WatchListState> {
  WatchListViewModel() : super(LoadingState());

  //todo: hold data & handle logic 4-4-2
  getMovies() async {
    var response = await ApiManager.getAllFavoritesMovies();
    emit(LoadingState());
    if (response.message == "favourites fetched successfully") {
      emit(SuccessState(movies: response.data ?? []));
    } else {
      emit(ErrorState(message: response.message ?? ''));
    }
  }
}
