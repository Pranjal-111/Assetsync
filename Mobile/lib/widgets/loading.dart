import 'package:assetsync/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SpinKitSpinningLines(
          size: 100,
          itemCount: 10,
          color: kPrimaryColor,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Please Wait...",
          style: TextStyle(color: kPrimaryColor),
        ),
      ],
    ));
  }
}
