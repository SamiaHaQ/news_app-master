
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/business_logic/services/firebase_services/auth_services.dart';
import 'package:news_app/src/view/blocs/signup/signup_events.dart';
import 'package:news_app/src/view/blocs/signup/signup_states.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState>{
  SignUpBloc(SignUpState initialState) : super(initialState);

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async*{
    if (event is SignUpToUserAccount){
      yield SignUpLoadingState();
      try {
        var createNewUser = await FirebaseAuthService.createNewUser( event.email, event.password);
        if (createNewUser){
          var uploadData = await FirebaseAuthService.uploadUserData(event.email, FirebaseAuthService.user.uid, event.userName);
          if (uploadData){
            yield SignUpSuccessState();
          } else {
            yield SignUpFailedState(message: FirebaseAuthService.errorMessage);
          }
        } else {
          yield SignUpFailedState(message: FirebaseAuthService.errorMessage);
        }
      } catch (e){
        yield SignUpErrorState();
      }
    }
  }

}