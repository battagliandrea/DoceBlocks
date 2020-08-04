import 'dart:developer';

import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {

    log(event.toString());

    if(event is LoginButtonPressed){
      var userRepository = Injector.provideUserRepository();

      try{
        await userRepository.authenticate(email: event.email, password: event.password);
        yield LoginSuccess();
      } on PlatformException catch (exception) {
        yield LoginFailure(error: exception.message);
      } catch (error) {
        yield LoginFailure(error: 'Generic Error!');
      }
    } else {
      yield LoginInitial();
    }
  }
}