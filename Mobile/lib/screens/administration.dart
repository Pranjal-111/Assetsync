import 'package:assetsync/screens/add_admin.dart';
import 'package:assetsync/utils/style.dart';
import 'package:flutter/material.dart';

class Administration extends StatelessWidget {
  const Administration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (builder) {
                return const AddAdmin();
              });
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          color: kWhite,
        ),
      ),
      body: Container(
        color: kBGcolor,
      ),
    );
  }
}
