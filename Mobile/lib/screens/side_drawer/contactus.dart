import 'package:assetsync/bloc/connection_cubit.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/error.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:assetsync/widgets/no_internet.dart';
import 'package:assetsync/widgets/simple_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGcolor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Center(
          child: Text(
            'Contact us',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: const [
          SizedBox(
            width: 56,
          ),
        ],
      ),
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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                    width: double.infinity,
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
                    height: 16,
                  ),
                  SimpleTile(
                    title: "admin@assetsyn.tech",
                    ontap: () async {
                      await launchUrl(
                        Uri(
                          scheme: 'mailto',
                          path: 'admin@assetsyn.tech',
                        ),
                      );
                    },
                    firsticon: const Icon(
                      Icons.email,
                      color: kPrimaryColor,
                    ),
                    lasticon: const Icon(
                      Icons.arrow_forward_ios,
                      color: kPrimaryColor,
                    ),
                  ),
                  SimpleTile(
                    title: "+91 9998887776",
                    ontap: () async {
                      await launchUrl(
                        Uri(
                          scheme: 'tel',
                          path: '99988877766',
                        ),
                      );
                    },
                    firsticon: const Icon(
                      Icons.phone,
                      color: kPrimaryColor,
                    ),
                    lasticon: const Icon(
                      Icons.arrow_forward_ios,
                      color: kPrimaryColor,
                    ),
                  ),
                  SimpleTile(
                    title: "www.assetsync.tech",
                    ontap: () async {
                      await launchUrl(Uri.parse('https://www.assetsync.tech'),
                          mode: LaunchMode.externalApplication);
                    },
                    firsticon: const Icon(
                      Icons.public,
                      color: kPrimaryColor,
                    ),
                    lasticon: const Icon(
                      Icons.arrow_forward_ios,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}
