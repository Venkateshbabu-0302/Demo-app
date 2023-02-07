import 'package:demo_login/core/res/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/res/strings.dart';
import '../../repo/repositories.dart';
import '../../repo/user_model.dart';
import '../detailPage/detail_page.dart';
import 'blocs/homePage_blocs.dart';
import 'blocs/homePage_events.dart';
import 'blocs/homePage_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository()),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(title:  Text(users)),
          body: blocBody()),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(),
      )..add(LoadHomePageEvent()),
      child: BlocBuilder<UserBloc, HomePageState>(
        builder: (context, state) {
          if (state is HomePageLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomePageErrorState) {
            return const Center(child:  Text("Error"));
          }
          if (state is HomeSuccessState) {
            List<UserModel> userList = state.users;
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (BuildContext context, int index) {

                return Card(
                  color: Colors.white24,
                  margin: const EdgeInsets.symmetric(horizontal: padding05,vertical: padding10),
                  child:ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: padding05,vertical: padding20),
                    title: Text('${userList[index].firstName}  ${userList[index].lastName}',),
                    subtitle: Text('${userList[index].email}',),
                    leading: SizedBox(
                        child:Image.network(userList[index].avatar.toString()),
                      ),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DetailPage(user:userList[index]))
                      );

                    },

                  )
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}


