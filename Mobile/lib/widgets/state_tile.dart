import 'package:assetsync/model/state_model.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/custom_expansion_tile.dart';
import 'package:flutter/material.dart';

class StateTile extends StatelessWidget {
  final int index;
  final StateModel stateModel;
  final VoidCallback ontap;
  const StateTile({Key? key, required this.index, required this.stateModel,required this.ontap})
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
                stateModel.name,
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
                    stateModel.email,
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
                    stateModel.phone,
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
                    stateModel.username,
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
