import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//Colors of the app defined here

const kPrimaryDark = Color(0xFF0063B1);
const kPrimaryLight = Color.fromARGB(255, 125, 243, 132);
const kPrimaryColor = Color(0xff4ba94f);
const kBGcolor = Color(0xffdfffe0);
const kWhite = Colors.white;
const kGrey = Color(0xfffafafa);
const kUnSelected = Color(0xffb6def7);

TextStyle kHeadingTextStyle = const TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);
TextStyle kSubHeadingTextStyle = const TextStyle(
  fontSize: 18,
  color: kPrimaryLight,
);

TextStyle kNormalTextStyle = const TextStyle(
  fontSize: 16,
  fontStyle: FontStyle.italic,
  color: kPrimaryLight,
);

TextStyle kLinkTextStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
  decoration: TextDecoration.underline,
);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  labelStyle: TextStyle(color: kPrimaryColor),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);
AppBar appbar(GlobalKey<ScaffoldState> key) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    centerTitle: true,
    leading: InkWell(
      child: const Icon(Icons.menu),
      onTap: () {
        key.currentState!.openDrawer();
      },
    ),
    automaticallyImplyLeading: false,
    title: const Text(
      "AssetSync",
    ),
  );
}

AppBar simpleappbar() {
  return AppBar(
    backgroundColor: kPrimaryColor,
    title: const Text("Assetsync", style: TextStyle(color: kWhite)),
    centerTitle: true,
  );
}

Future<dynamic> progressbar(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builder) {
        return const Center(
            child: SpinKitSpinningLines(
          size: 100,
          itemCount: 10,
          color: kPrimaryColor,
        ));
      });
}
