import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repo/repo_auth.dart';
import '../../../../../core/res/strings.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final AuthRepo _authRepo;
  RegisterBloc(this._authRepo) : super(RegisterLoading()) {
    on<SignUpEvent>((event, emit)  async {
      final result = await _authRepo.register(event.email,event.password );

      if(result.toString() == missingEmail || result.toString() == missingPassword || result.toString() == note) {
        emit(RegisterError(error));
      }
      else{
        emit(RegisterSuccessful());
      }

    });
  }
}

