import 'package:bloc_test_2/auth/auth_repository.dart';
import 'package:bloc_test_2/auth/login/login_bloc.dart';

LoginBloc loginBlocSetup() {
  AuthRepository authRepo = AuthRepository();
  return LoginBloc(authRepo: authRepo);
}
