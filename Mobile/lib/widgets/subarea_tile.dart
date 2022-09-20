import 'package:assetsync/model/subarea_model.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/custom_expansion_tile.dart';
import 'package:flutter/material.dart';

class SubAreaTile extends StatelessWidget {
  final int index;
  final SubAreaModel subAreaModel;
  final VoidCallback ontap;
  const SubAreaTile(
      {Key? key,
      required this.ontap,
      required this.index,
      required this.subAreaModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomExpansionTile(
        backgroundColor: kWhite,
        collapsedBackgroundColor: kWhite,
        textColor: kPrimaryColor,
        collapsedTextColor: kPrimaryColor,
        leading: CircleAvatar(
          backgroundColor: kPrimaryColor,
          child: Text(
            '${index + 1}',
            style: const TextStyle(
                color: kWhite, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                subAreaModel.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: ontap,
              child: const Icon(
                Icons.arrow_circle_right_outlined,
                color: kPrimaryColor,
                size: 36,
              ),
            )
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'E-mail :',
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    subAreaModel.email,
                    style: const TextStyle(color: kPrimaryColor),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Phone :',
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    subAreaModel.phone,
                    style: const TextStyle(color: kPrimaryColor),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Username :',
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    subAreaModel.username,
                    style: const TextStyle(color: kPrimaryColor),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}
