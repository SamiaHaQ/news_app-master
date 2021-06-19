import 'package:flutter/material.dart';
import 'package:news_app/src/view/utils/constants.dart';
import 'package:news_app/src/view/utils/reuseable_widgets.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({@required this.email});
  final String email;
  @override
  _ChangePasswordState createState() => _ChangePasswordState(email: email);
}

class _ChangePasswordState extends State<ChangePassword> {
  _ChangePasswordState({@required this.email});
  final String email;
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

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
                    child: Text('Change Password', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0.6)),
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
                child: Text('example@gmail.com', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, letterSpacing: 0.6)),
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
                          hint: 'Current Password',
                          obscureText: true,
                          textEditingController: _currentPasswordController,
                          iconData: Icons.person
                      ),
                      SizedBox(height: 10,),
                      InputTextField(
                          forgotOption: false,
                          forgotFunction: null,
                          textInputType: TextInputType.text,
                          hint: 'New Password',
                          obscureText: true,
                          textEditingController: _newPasswordController,
                          iconData: Icons.person
                      ),
                      SizedBox(height: 15,),
                      RoundedButton(
                        inProgress: false,
                        onPressed: (){

                        },
                        buttonText: 'Save Changes',
                        disable: false,
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
