import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repo/repo_auth.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/signupBloc/register_bloc.dart';
import 'login_view.dart';

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) :super(key:key);

  @override
  Widget build(BuildContext context){
    return MultiBlocProvider(
      providers: [
      BlocProvider(create:(context)=>AuthBloc(AuthRepo())
      ),
      BlocProvider(create:(context)=>RegisterBloc(AuthRepo())
      )

    ], child: const MaterialApp(
      home:LoginView(),
      debugShowCheckedModeBanner: false,
    ),
    );

  }
}
