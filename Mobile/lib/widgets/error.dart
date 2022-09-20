import 'package:assetsync/utils/style.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/error.png',
          height: 200,
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
          'Something Went Wrong',
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
          'Something Went Wrong Please Try After Some Time !',
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
