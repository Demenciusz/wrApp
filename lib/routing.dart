import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wr/cubit/scaffoldcubit_cubit.dart';
import 'package:wr/beforlogin/loginpage.dart';
import 'package:wr/main.dart';
import 'package:wr/afterlogin/mainpage.dart';
import 'package:wr/afterlogin/myprofile/myprofile.dart';
import 'package:wr/beforlogin/registerpage.dart';

class RouteGenerator {
  RouteGenerator();
  ScaffoldcubitCubit routeCubit = ScaffoldcubitCubit();
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [BlocProvider.value(value: routeCubit)],
                  child: const BuilderWidget(),
                ));
      case '/register':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: routeCubit),
                  ],
                  child: const RegisterPage(),
                ));
      /*
      case '/x':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: routeCubit),
                  ],
                  child: const RegisterPage(),
                ));
      case '/main':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: routeCubit),
                  ],
                  child: const MainMenuPage(),
                ));
      case '/myprofile':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: routeCubit),
                  ],
                  child: const MyProfile(),
                ));
                */
    }
    return MaterialPageRoute(builder: (_) => const BuilderWidget());
  }
}
