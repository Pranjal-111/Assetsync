import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/screens/auth/change_password.dart';
import 'package:assetsync/screens/auth/login.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/simple_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAccount extends StatelessWidget {
  const AdminAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<GloablAuthCubit>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            "Account",
            style: kHeadingTextStyle,
          ),
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 100,
            backgroundColor: kWhite,
            child: Image.asset(
              'images/logo.png',
              height: 150,
              width: 150,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SimpleTile(
            title: blocProvider.adminModel!.name,
            ontap: () {},
            firsticon: const Icon(
              Icons.verified,
              color: kPrimaryColor,
            ),
            lasticon: const Icon(
              Icons.arrow_forward_ios,
              color: kWhite,
            ),
          ),
          SimpleTile(
            title: blocProvider.adminModel!.username,
            ontap: () {},
            firsticon: const Icon(
              Icons.person,
              color: kPrimaryColor,
            ),
            lasticon: const Icon(
              Icons.arrow_forward_ios,
              color: kWhite,
            ),
          ),
          SimpleTile(
            title: blocProvider.adminModel!.phone,
            ontap: () {},
            firsticon: const Icon(
              Icons.phone,
              color: kPrimaryColor,
            ),
            lasticon: const Icon(
              Icons.arrow_forward_ios,
              color: kWhite,
            ),
          ),
          SimpleTile(
            title: blocProvider.adminModel!.email,
            ontap: () {},
            firsticon: const Icon(
              Icons.email,
              color: kPrimaryColor,
            ),
            lasticon: const Icon(
              Icons.arrow_forward_ios,
              color: kWhite,
            ),
          ),
          SimpleTile(
              title: "Change Passsword",
              lasticon: const Icon(
                Icons.arrow_forward_ios,
                color: kPrimaryColor,
              ),
              ontap: () {
                changeScreen(context, const ChangePassword());
              },
              firsticon: const Icon(
                Icons.published_with_changes,
                color: kPrimaryColor,
              )),
          SimpleTile(
            title: "Logout",
            lasticon: const Icon(
              Icons.arrow_forward_ios,
              color: kPrimaryColor,
            ),
            ontap: () {
              blocProvider.logout();
              changeScreenReplacement(context, const Login());
            },
            firsticon: const Icon(
              Icons.power_settings_new,
              color: kPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}
