import 'dart:async';

import 'package:bloc_test_2/auth/auth_repository.dart';
import 'package:bloc_test_2/auth/form_submission_status.dart';
import 'package:bloc_test_2/auth/login/login_state.dart';
import 'package:bloc_test_2/di/bloc_setup.dart';

class LoginBloc {
  final AuthRepository authRepo;

  LoginState _loginState = LoginState();

  final StreamController<LoginState> _loginSubject =
      StreamController<LoginState>.broadcast();

  Stream<LoginState> get stream => _loginSubject.stream;

  LoginBloc({
    required this.authRepo,
  });

  void userNameChanged(String userName) {
    _loginState = _loginState.copyWith(userName: userName);
    _loginSubject.add(_loginState);
  }

  void passwordChanged(String password) {
    _loginState = _loginState.copyWith(password: password);
    _loginSubject.add(_loginState);
  }

  void login() async {
    _loginState = _loginState.copyWith(formStatus: FormSubmitting());
    _loginSubject.add(_loginState);
    try {
      await authRepo.login();
      _loginState = _loginState.copyWith(formStatus: SubmissionSuccess());
      _loginSubject.add(_loginState);
    } on Exception catch (e) {
      _loginState = _loginState.copyWith(formStatus: SubmissionFailed(e));
      _loginSubject.add(_loginState);
    }
  }

  void dispose() {
    _loginSubject.close();
  }
}

final LoginBloc loginBloc = loginBlocSetup();
