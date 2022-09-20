import 'package:assetsync/model/assests_count_model.dart';
import 'package:assetsync/utils/style.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';

class AssetsCountTile extends StatelessWidget {
  final int index;
  final AssetsCountModel assetsCountModel;
  const AssetsCountTile(
      {Key? key, required this.index, required this.assetsCountModel})
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
                assetsCountModel.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Countup(
                begin: 0,
                end: assetsCountModel.count + 0.0,
                style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                duration: const Duration(seconds: 3),
              ),
            )
          ],
        ));
  }
}
