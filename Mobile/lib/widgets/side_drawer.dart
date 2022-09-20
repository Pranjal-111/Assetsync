import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/screens/auth/login.dart';
import 'package:assetsync/screens/side_drawer/aboutus.dart';
import 'package:assetsync/screens/side_drawer/contactus.dart';
import 'package:assetsync/screens/side_drawer/privacy.dart';
import 'package:assetsync/screens/side_drawer/terms_and_conditons.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideDrawer extends StatelessWidget {
  final String name;
  final String username;
  const SideDrawer({Key? key, required this.name, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<GloablAuthCubit>(context);

    return SafeArea(
      child: Drawer(
        backgroundColor: kBGcolor,
        child: ListView(
          children: [
            Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(16))), //BoxDecoration
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: kBGcolor,
                      child: Image.asset(
                        'images/logo.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      name,
                      style: kHeadingTextStyle.copyWith(
                          color: kWhite, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      username,
                      style: kHeadingTextStyle.copyWith(
                          color: kWhite, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ) //UserAccountDrawerHeader
                ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      changeScreen(context, const PrivacyPloicy());
                    },
                    tileColor: kWhite,
                    leading: const Icon(
                      Icons.policy,
                      color: kPrimaryColor,
                    ),
                    title: const Text(
                      "Privacy Policy",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    onTap: () {
                      changeScreen(context, const TermsAndCondtions());
                    },
                    tileColor: kWhite,
                    leading: const Icon(
                      Icons.gavel,
                      color: kPrimaryColor,
                    ),
                    title: const Text(
                      "Terms And Condition",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    onTap: () {
                      changeScreen(context, const AboutUs());
                    },
                    tileColor: kWhite,
                    leading: const Icon(
                      Icons.info,
                      color: kPrimaryColor,
                    ),
                    title: const Text(
                      "About us",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    onTap: () {
                      changeScreen(context, const ContactUs());
                    },
                    tileColor: kWhite,
                    leading: const Icon(
                      Icons.contact_support,
                      color: kPrimaryColor,
                    ),
                    title: const Text(
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
    );
  }
}
