import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/business_logic/models/user.dart';
import 'package:news_app/src/view/blocs/profile/profile_bloc.dart';
import 'package:news_app/src/view/blocs/profile/profile_events.dart';
import 'package:news_app/src/view/blocs/profile/profile_states.dart';
import 'package:news_app/src/view/utils/constants.dart';
import 'package:news_app/src/view/utils/reuseable_widgets.dart';

class ChangeUsername extends StatefulWidget {
  final User user;
  ChangeUsername({@required this.user});
  @override
  _ChangeUsernameState createState() => _ChangeUsernameState(user: this.user);
}

class _ChangeUsernameState extends State<ChangeUsername> {
  _ChangeUsernameState({@required this.user});
  final User user;
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  BackButton(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Text('Change Username', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0.6)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.verified_user,
                  size: 100,
                  color: kDarkBlueColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(user.email, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, letterSpacing: 0.6)),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      InputTextField(
                          forgotOption: false,
                          forgotFunction: null,
                          textInputType: TextInputType.text,
                          hint: 'Enter your new username',
                          obscureText: false,
                          textEditingController: _userNameController,
                          iconData: Icons.person
                      ),
                      SizedBox(height: 15,),
                      BlocBuilder(
                        bloc: BlocProvider.of<ProfileBloc>(context),
                        builder: (context, state){
                          if (state is ProfileUserNameChangedSuccessState){
                            BotToast.showText(text: 'Username changed!', contentColor: Colors.lightGreen, textStyle: TextStyle(color: Colors.white));
                            BlocProvider.of<ProfileBloc>(context).add(ProfileFetchEvent());
                          }
                          return RoundedButton(
                            inProgress: state is ProfileLoadingState,
                            onPressed: (){
                              if (_userNameController.text.trim().isNotEmpty) {
                                BlocProvider.of<ProfileBloc>(context).add(ProfileChangeUsernameEvent(userName: _userNameController.text.trim()));
                              } else {
                                BotToast.showText(text: 'Enter a valid username!', contentColor: Colors.red, textStyle: TextStyle(color: Colors.white));
                              }
                            },
                            buttonText: 'Save Changes',
                            disable: false,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        )
    );
  }
}
