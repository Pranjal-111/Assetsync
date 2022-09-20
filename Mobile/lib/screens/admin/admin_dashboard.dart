import 'package:assetsync/bloc/connection_cubit.dart';
import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/screens/admin/admin_account.dart';
import 'package:assetsync/screens/admin/admin_administration.dart';
import 'package:assetsync/screens/admin/admin_home.dart';
import 'package:assetsync/screens/admin/admin_stats.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/error.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:assetsync/widgets/no_internet.dart';
import 'package:assetsync/widgets/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboard();
}

class _AdminDashboard extends State<AdminDashboard> {
  int index = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final List<Widget> pages = const [
    AdminHome(),
    AdminStats(),
    AdminAdministration(),
    AdminAccount()
  ];
  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<GloablAuthCubit>(context);

    return Scaffold(
      backgroundColor: kBGcolor,
      key: _key,
      appBar: appbar(_key),
      drawer: SideDrawer(
        name: blocProvider.adminModel!.name,
        username: blocProvider.adminModel!.username,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: ((value) {
            setState(() {
              index = value;
            });
          }),
          currentIndex: index,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kPrimaryColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.query_stats), label: 'Stats'),
            BottomNavigationBarItem(
                icon: Icon(Icons.admin_panel_settings),
                label: 'Administration'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ]),
      body: BlocBuilder<ConnectionCubit, ConnectionStates>(
          builder: (context, state) {
        switch (state) {
          case ConnectionStates.checking:
            return const Loading();
          case ConnectionStates.notConnected:
            return const NoInternet();
          case ConnectionStates.error:
            return const ErrorScreen();
          case ConnectionStates.connected:
            return pages[index];
        }
      }),
    );
  }
}
