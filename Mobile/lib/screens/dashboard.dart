import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/screens/account.dart';
import 'package:assetsync/screens/administration.dart';
import 'package:assetsync/screens/auth/login.dart';
import 'package:assetsync/screens/home.dart';
import 'package:assetsync/screens/stats.dart';
import 'package:assetsync/screens/view_on_map.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final List<Widget> pages = const [
    Home(),
    ViewOnMap(),
    Stats(),
    Administration(),
    Account()
  ];
  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<GloablAuthCubit>(context);
    return Scaffold(
      key: _key,
      appBar: appbar(_key),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ), //BoxDecoration
                child: Center(
                    child: Text(
                  "AssetSync",
                  style: kHeadingTextStyle.copyWith(color: kWhite),
                )) //UserAccountDrawerHeader
                ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const ListTile(
                    tileColor: kWhite,
                    leading: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const ListTile(
                    tileColor: kWhite,
                    leading: Icon(
                      Icons.policy,
                      color: kPrimaryColor,
                    ),
                    title: Text(
                      "Privacy Policy",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const ListTile(
                    tileColor: kWhite,
                    leading: Icon(
                      Icons.gavel,
                      color: kPrimaryColor,
                    ),
                    title: Text(
                      "Terms And Condition",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const ListTile(
                    tileColor: kWhite,
                    leading: Icon(
                      Icons.info,
                      color: kPrimaryColor,
                    ),
                    title: Text(
                      "About us",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const ListTile(
                    tileColor: kWhite,
                    leading: Icon(
                      Icons.contact_support,
                      color: kPrimaryColor,
                    ),
                    title: Text(
                      "Contact",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    onTap: () {
                      blocProvider.logout();
                      changeScreenReplacement(context, const Login());
                    },
                    tileColor: kWhite,
                    leading: const Icon(
                      Icons.logout,
                      color: kPrimaryColor,
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ) //Drawe
          ],
        ),
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
                icon: Icon(Icons.location_on), label: 'Map View'),
            BottomNavigationBarItem(
                icon: Icon(Icons.query_stats), label: 'Stats'),
            BottomNavigationBarItem(
                icon: Icon(Icons.admin_panel_settings),
                label: 'Administration'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ]),
      body: pages[index],
    );
  }
}
