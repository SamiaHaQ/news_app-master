import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/app.dart';
import 'package:news_app/src/view/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:news_app/src/view/blocs/forgot_password/forgot_password_states.dart';
import 'package:news_app/src/view/blocs/home/home_bloc.dart';
import 'package:news_app/src/view/blocs/home/home_states.dart';
import 'package:news_app/src/view/blocs/profile/profile_bloc.dart';
import 'package:news_app/src/view/blocs/profile/profile_states.dart';
import 'package:news_app/src/view/blocs/search/search_bloc.dart';
import 'package:news_app/src/view/blocs/search/search_states.dart';
import 'package:news_app/src/view/blocs/signin/signin_bloc.dart';
import 'package:news_app/src/view/blocs/signin/signin_states.dart';
import 'package:news_app/src/view/blocs/signup/signup_bloc.dart';
import 'package:news_app/src/view/blocs/signup/signup_states.dart';

void main() {
  var blocProvider = MultiBlocProvider(
    providers: [
      BlocProvider<SignUpBloc>(
        create: (BuildContext context) => SignUpBloc(SignUpInitialState()),
      ),
      BlocProvider<SignInBloc>(
        create: (BuildContext context) => SignInBloc(SignInInitialState()),
      ),
      BlocProvider<ForgotPasswordBloc>(
        create: (BuildContext context) => ForgotPasswordBloc(ForgotPasswordInitialState()),
      ),
      BlocProvider<HomeBloc>(
        create: (BuildContext context) => HomeBloc(HomeInitialState()),
      ),
      BlocProvider<SearchBloc>(
        create: (BuildContext context) => SearchBloc(SearchInitialState()),
      ),
      BlocProvider<ProfileBloc>(
        create: (BuildContext context) => ProfileBloc(ProfileInitialState()),
      ),
    ],
    child: NewsApp(),
  );
  runApp(blocProvider);
}