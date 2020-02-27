import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitor_machine_test/bloc/user_bloc/user_bloc.dart';
import 'package:nitor_machine_test/data/repository_impl.dart/user_repository_impl.dart';
import 'package:nitor_machine_test/screens/home_page.dart';
import 'package:nitor_machine_test/screens/user_followers_page.dart';
import 'package:nitor_machine_test/screens/user_info_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (BuildContext context) => UserBloc(),
          ),
        ],
        child: MaterialApp(
          routes: {
            HomePage.route: (context) => HomePage(),
            UserInfoPage.route: (context) => UserInfoPage(
                  user: ModalRoute.of(context).settings.arguments,
                ),
            UsersFollowersPage.route: (context) => UsersFollowersPage(
                  user: ModalRoute.of(context).settings.arguments,
                )
          },
          title: 'GitHub Demo',
          theme: ThemeData(
            fontFamily: "Gafata",
            primarySwatch: Colors.deepPurple,
          ),
          home: BlocProvider(
            create: (context) => UserBloc(userRepository: UserRepositoryImpl()),
            child: HomePage(),
          ),
          debugShowCheckedModeBanner: false,
        ));
  }
}
