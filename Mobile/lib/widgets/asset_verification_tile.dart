import 'package:assetsync/utils/style.dart';
import 'package:flutter/material.dart';

class AssetVerificationTile extends StatelessWidget {
  final int index;
  final String title;
  const AssetVerificationTile(
      {Key? key, required this.index, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(color: kPrimaryColor, blurRadius: 3, spreadRadius: 1)
            ]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CircleAvatar(
                backgroundColor: kPrimaryColor,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                      color: kWhite, fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.arrow_circle_right_outlined,
                color: kPrimaryColor,
              ),
            ),
          ],
        ));
  }
}
