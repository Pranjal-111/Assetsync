import 'package:assetsync/utils/style.dart';
import 'package:flutter/material.dart';

class SimpleTile extends StatelessWidget {
  const SimpleTile(
      {Key? key,
      required this.title,
      required this.firsticon,
      required this.lasticon,
      required this.ontap})
      : super(key: key);

  final String title;
  final Widget firsticon;
  final VoidCallback ontap;
  final Widget lasticon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 1)
          ],
          color: kWhite,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
              child: Container(
                // margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.30),
                          spreadRadius: 2,
                          blurRadius: 1)
                    ]),
                child: CircleAvatar(
                  backgroundColor: kWhite,
                  child: firsticon,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  title,
                  style: const TextStyle(color: kPrimaryColor, fontSize: 18),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(8.0), child: lasticon)
          ],
        ),
      ),
    );
  }
}
