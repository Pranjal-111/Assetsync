import 'package:assetsync/bloc/connection_cubit.dart';
import 'package:assetsync/utils/constant.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/error.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:assetsync/widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndCondtions extends StatelessWidget {
  const TermsAndCondtions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGcolor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Center(
          child: Text(
            'Terms And Condtions',
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
            return WebView(
              initialUrl: termsAndCondtionsURL,
              zoomEnabled: false,
              onPageStarted: ((url) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Center(child: Text('Please Wait !')),
                        content: LinearProgressIndicator(),
                      );
                    });
              }),
              onPageFinished: (url) {
                Navigator.pop(context);
              },
            );
        }
      }),
    );
  }
}
