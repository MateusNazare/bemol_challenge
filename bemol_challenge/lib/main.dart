import 'package:bemolChallenge/src/bloc/ViaCep/ViaCepBloc.dart';
import 'package:bemolChallenge/src/bloc/user/UserBloc.dart';
import 'package:bemolChallenge/src/views/user/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bemol Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<ViaCepBloc>(
          create: (BuildContext context) => ViaCepBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
      ], child: const SignUp()),
    );
  }
}
