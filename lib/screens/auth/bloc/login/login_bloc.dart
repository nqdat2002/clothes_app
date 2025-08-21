import 'package:bloc/bloc.dart';
import 'package:clothes_app/repository/auth/auth_repository.dart';
import 'package:clothes_app/screens/auth/bloc/form/form_submission_status.dart';
import 'package:clothes_app/screens/auth/bloc/login/login_event.dart';
import 'package:clothes_app/screens/auth/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginBloc({required AuthenticationRepository authRepository}): _authRep = authRepository, super(const LoginState()){
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final AuthenticationRepository _authRep;

  // @override
  // Stream<LoginState> mapEventToState(LoginState event) async*{
  //   if (event is LoginUserNameChanged){
  //     yield state.copyWith(username: event.username);
  //   }
  //   else if (event is LoginPasswordChanged){
  //     yield state.copyWith(password: event.password);
  //   }
  //   else if (event is LoginSubmitted){
  //     yield state.copyWith(formStatus: FormSubmitting());
  //   }
  // }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) async {
    final email = event.email;

    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) async {
    final password = event.password;

    emit(state.copyWith(password: password));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try{
      await _authRep.login(email: event.email, password: event.password);
      emit(state.copyWith(formStatus: SubmissionSuccess()));
    }
    catch (ex){
      emit(state.copyWith(formStatus: SubmissionFailed(exception: ex.toString())));
    }
  }
}