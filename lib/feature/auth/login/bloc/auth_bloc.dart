import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repo/repo_auth.dart';
import '../../../../core/res/strings.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepo _authRepo;
  AuthBloc(this._authRepo) : super(AuthLoading()) {
    on<LoginEvent>((event, emit)  async {
      final result = await _authRepo.login(event.email,event.password );
      print(result);

       if(result == missingPassword || result == notFound || result== missingEmail) {
         emit(AuthError(error));
       }
       else{
      emit(AuthSuccessful());
      }

    });
    }

  }

