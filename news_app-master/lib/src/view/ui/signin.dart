import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/business_logic/services/firebase_services/auth_services.dart';
import 'package:news_app/src/view/blocs/signin/signin_bloc.dart';
import 'package:news_app/src/view/blocs/signin/signin_events.dart';
import 'package:news_app/src/view/blocs/signin/signin_states.dart';
import 'package:news_app/src/view/ui/forgot_password.dart';
import 'package:news_app/src/view/ui/signup.dart';
import 'package:news_app/src/view/utils/constants.dart';
import 'package:news_app/src/view/utils/reuseable_widgets.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController, _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<SignInBloc>(context).listen((state) {
      if (state is SignInSuccessState ) {
        if (FirebaseAuthService.user != null) {
          print('---------------------- signIn success ------------------');
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) =>
                  Home()));
        }
      }
    });

    return Scaffold(
      backgroundColor: kSoftGreenColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'News App',
                style: TextStyle(
                  color: kWhiteColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 30
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Know around the world',
                style: TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                    fontSize: 18
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30),)
                ),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Sign In',
                        style: TextStyle(
                            color: kSoftBlackColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 20
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InputTextField(
                        obscureText: false,
                        forgotOption: false,
                        hint: 'Email',
                        iconData: Icons.email,
                        textEditingController: _emailController,
                        textInputType: TextInputType.emailAddress,
                        forgotFunction: null,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextField(
                        forgotOption: true,
                        obscureText: true,
                        hint: 'Password',
                        iconData: Icons.lock,
                        textEditingController: _passwordController,
                        textInputType: TextInputType.text,
                        forgotFunction: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ForgotPassword()
                          ));
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      BlocBuilder(
                        bloc: BlocProvider.of<SignInBloc>(context),
                        builder: (context, state) {
                          if (state is SignInFailedState){
                            BotToast.showText(
                                text: state.message,
                                contentColor: Colors.red,
                                textStyle: TextStyle(
                                    color: Colors.white
                                )
                            );
                          } else if (state is SignInErrorState){
                            BotToast.showText(
                                text: 'Something went wrong!',
                                contentColor: Colors.red,
                                textStyle: TextStyle(
                                    color: Colors.white
                                )
                            );
                          }
                          return RoundedButton(
                            inProgress: state is SignInLoadingState,
                            disable: state is SignInLoadingState,
                            onPressed: (){
                              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController.text.trim());
                              if (emailValid){
                                if (_passwordController.text.length > 6){
                                  BlocProvider.of<SignInBloc>(context).add(SignInOnUserAccount(
                                      email: _emailController.text.trim(), password: _passwordController.text
                                  ));
                                } else {
                                  BotToast.showText(
                                      text: 'Password must be more than 6 letters!',
                                      contentColor: Colors.red,
                                      textStyle: TextStyle(
                                          color: Colors.white
                                      )
                                  );
                                }
                              } else {
                                BotToast.showText(
                                    text: 'Enter a valid email!',
                                    contentColor: Colors.red,
                                    textStyle: TextStyle(
                                        color: Colors.white
                                    )
                                );
                              }
                            },
                            buttonText: 'Sign In',
                          );
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          'Create a new account',
                          style: TextStyle(
                            color: kDarkBlueColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        '@copyright reserved',
                        style: TextStyle(
                            color: kDarkBlueColor,
                            fontSize: 12,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


