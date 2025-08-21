import 'package:bloc/bloc.dart';
import 'package:clothes_app/repository/auth/auth_repository.dart';
import 'package:clothes_app/screens/auth/bloc/form/form_submission_status.dart';
import 'package:clothes_app/screens/auth/bloc/signup/signup_event.dart';
import 'package:clothes_app/screens/auth/bloc/signup/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState>{
  SignupBloc({required AuthenticationRepository authRepository}): _authRep = authRepository, super(const SignupState()){
    on<SignupEmailChanged>(_onEmailChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  final AuthenticationRepository _authRep;

  void _onEmailChanged(SignupEmailChanged event, Emitter<SignupState> emit) async {
    final email = event.email;

    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(SignupPasswordChanged event, Emitter<SignupState> emit) async {
    final password = event.password;

    emit(state.copyWith(password: password));
  }

  void _onSignupSubmitted(SignupSubmitted event, Emitter<SignupState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try{
      await _authRep.signup(email: event.email, password: event.password);
      emit(state.copyWith(formStatus: SubmissionSuccess()));
    }
    catch (ex){
      emit(state.copyWith(formStatus: SubmissionFailed(exception: ex.toString())));
    }
  }
}