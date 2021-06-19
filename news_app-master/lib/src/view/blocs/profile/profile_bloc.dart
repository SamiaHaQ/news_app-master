import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/business_logic/services/firebase_services/auth_services.dart';
import 'package:news_app/src/view/blocs/profile/profile_events.dart';
import 'package:news_app/src/view/blocs/profile/profile_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileState initialState) : super(initialState);

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async*{
    if (event is ProfileFetchEvent){
      yield ProfileLoadingState();
      try{
        var _response = await FirebaseAuthService.loadUserData();
        print('----------------------------- $_response -----------------------------');
        if (_response){
          yield ProfileDataFetchedState(user: FirebaseAuthService.userData);
        } else {
          yield ProfileFailedState();
        }
      } catch (_){
        yield ProfileErrorState();
      }
    } else if (event is ProfileChangeUsernameEvent){
      yield ProfileLoadingState();
      try{
        var _response = await FirebaseAuthService.changeUserName(event.userName);
        print('----------------------------- $_response -----------------------------');
        if (_response){
          yield ProfileUserNameChangedSuccessState();
        } else {
          yield ProfileFailedState();
        }
      } catch (_){
        yield ProfileErrorState();
      }
    }
  }

}