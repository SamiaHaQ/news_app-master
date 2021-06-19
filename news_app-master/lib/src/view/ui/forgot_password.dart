import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/view/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:news_app/src/view/blocs/forgot_password/forgot_password_events.dart';
import 'package:news_app/src/view/blocs/forgot_password/forgot_password_states.dart';
import 'package:news_app/src/view/utils/constants.dart';
import 'package:news_app/src/view/utils/reuseable_widgets.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        'Reset Password',
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
                        forgotOption: false,
                        obscureText: false,
                        hint: 'Email',
                        iconData: Icons.email,
                        textEditingController: _emailController,
                        textInputType: TextInputType.emailAddress,
                        forgotFunction: null,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      BlocBuilder(
                        bloc: BlocProvider.of<ForgotPasswordBloc>(context),
                        builder: (context, state){
                          if (state is ForgotPasswordErrorState){
                            BotToast.showText(
                                text: 'Something went wrong!',
                                contentColor: Colors.red,
                                textStyle: TextStyle(
                                    color: Colors.white
                                )
                            );
                          } else if (state is ForgotPasswordFailedState){
                            BotToast.showText(
                                text: state.message,
                                contentColor: Colors.red,
                                textStyle: TextStyle(
                                    color: Colors.white
                                )
                            );
                          } else if (state is ForgotPasswordSuccessState){
                            BotToast.showText(
                                text: "A mail has been sent to your email for reset your password!",
                                contentColor: kDarkGreenColor,
                                textStyle: TextStyle(
                                    color: Colors.white
                                ),
                              duration: Duration(seconds: 3)
                            );
                          }
                          return RoundedButton(
                            disable: state is ForgotPasswordLoadingState,
                            inProgress: state is ForgotPasswordLoadingState,
                            onPressed: (){
                              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController.text.trim());
                              if (emailValid){
                                BlocProvider.of<ForgotPasswordBloc>(context).add(ForgotPasswordResetEvent(email: _emailController.text.trim()));
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
                            buttonText: 'Send Email',
                          );
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Back to Sign In',
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
