
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/login/login_event.dart';
import 'package:hero_dex_go/bloc/login/login_state.dart';
import 'package:hero_dex_go/repositories/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthRepository _authRepository;

  LoginBloc({required AuthRepository authRepository}) : _authRepository = authRepository, super(LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, status: LoginStatus.initial));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, status: LoginStatus.initial));
    });

    on<LoginSubmitted>((event, emit) async {
      if (state.status == LoginStatus.loading) return;

      emit(state.copyWith(status: LoginStatus.loading));

      try {
        await _authRepository.logIn(
          email: state.email,
          password: state.password
        );

        emit(state.copyWith(status: LoginStatus.success));
      } catch (e) {
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: e.toString()
        ));
      }
    });

    on<RegisterSubmitted>((event, emit) async {
      if (state.status == LoginStatus.loading) return;

      emit(state.copyWith(status: LoginStatus.loading));

      try {
        await _authRepository.signUp(email: state.email, password: state.password);

        emit(state.copyWith(status: LoginStatus.success));
      } catch (e) {
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: e.toString()
        ));
      }
    });
  }

}