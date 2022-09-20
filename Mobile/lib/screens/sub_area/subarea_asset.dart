import 'package:assetsync/screens/sub_area/subarea_add_asset.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:flutter/material.dart';

class SubAreaAsset extends StatelessWidget {
  const SubAreaAsset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGcolor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          changeScreen(context, const SubAreaAddAsset());
        },
        child: const Icon(Icons.add, color: kWhite),
      ),
      body: const SingleChildScrollView(),
    );
  }
}
