import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/repositories.dart';
import 'homePage_events.dart';
import 'homePage_states.dart';

class UserBloc extends Bloc<HomePageEvent, HomePageState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(HomePageLoadingState()) {
    on<LoadHomePageEvent>((event, emit) async {
      emit(HomePageLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(HomeSuccessState(users));
      } catch (e) {
        emit(HomePageErrorState(e.toString()));
      }
    });
  }
}