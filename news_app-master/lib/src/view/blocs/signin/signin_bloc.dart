import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/business_logic/services/firebase_services/auth_services.dart';
import 'package:news_app/src/view/blocs/signin/signin_events.dart';
import 'package:news_app/src/view/blocs/signin/signin_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>{
  SignInBloc(SignInState initialState) : super(initialState);

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async*{
    if (event is SignInOnUserAccount){
      yield SignInLoadingState();
      try {
        var userSignUser = await FirebaseAuthService.userSignInAuth( event.email, event.password);
        if (userSignUser){
          yield SignInSuccessState();
        } else {
          yield SignInFailedState(message: FirebaseAuthService.errorMessage);
        }
      } catch (_){
        yield SignInErrorState();
      }
    }
  }

}