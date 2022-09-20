import 'package:assetsync/utils/style.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/no_internet.png',
          height: 200,
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
          'You\'re Offline',
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
          'Check Your Internet Connection',
          style: TextStyle(color: kPrimaryColor),
        ),
        const SizedBox(
          height: 25,
        ),
        MaterialButton(
            color: kPrimaryColor,
            onPressed: () {},
            child: const Text(
              'Try Again',
              style: TextStyle(color: kWhite),
            ))
      ],
    ));
  }
}
