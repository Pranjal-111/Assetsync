import 'package:assetsync/bloc/connection_cubit.dart';
import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/screens/admin/admin_dashboard.dart';
import 'package:assetsync/screens/auth/login.dart';
import 'package:assetsync/screens/district/district_dashboard.dart';
import 'package:assetsync/screens/state/state_dashboard.dart';
import 'package:assetsync/screens/sub_area/subarea_dashboard.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:assetsync/widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: ((context) => ConnectionCubit()),
          ),
          BlocProvider(
            create: ((context) => GloablAuthCubit()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<ConnectionCubit, ConnectionStates>(
              builder: (context, state) {
            switch (state) {
              case ConnectionStates.checking:
                return const Scaffold(
                  backgroundColor: kBGcolor,
                  body: Loading(),
                );
              case ConnectionStates.notConnected:
                return const Scaffold(
                  backgroundColor: kBGcolor,
                  body: NoInternet(),
                );
              case ConnectionStates.error:
                return const Scaffold(
                  backgroundColor: kBGcolor,
                  body: NoInternet(),
                );
              case ConnectionStates.connected:
                return BlocBuilder<GloablAuthCubit, AuthState>(
                    builder: (context, state) {
                  final blocProvider =
                      BlocProvider.of<GloablAuthCubit>(context);

                  switch (state) {
                    case AuthState.init:
                      return const Scaffold(
                        backgroundColor: kBGcolor,
                        body: Loading(),
                      );
                    case AuthState.loading:
                      return const Scaffold(
                        backgroundColor: kBGcolor,
                        body: Loading(),
                      );
                    case AuthState.loggedIn:
                      if (blocProvider.userType == 0) {
                        return const AdminDashboard();
                      } else if (blocProvider.userType == 1) {
                        return const StateDashboard();
                      } else if (blocProvider.userType == 2) {
                        return const DistrictDashboard();
                      } else if (blocProvider.userType == 3) {
                        return const SubAreaDashboard();
                      } else {
                        return const Login();
                      }

                    case AuthState.loggedOut:
                      return const Login();
                    case AuthState.error:
                      return const Scaffold(
                        backgroundColor: kBGcolor,
                        body: NoInternet(),
                      );
                  }
                });
            }
          }),
        ));
  }
}
