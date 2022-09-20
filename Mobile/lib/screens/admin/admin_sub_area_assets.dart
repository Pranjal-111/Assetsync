import 'package:assetsync/database/subarea_mysql_helper.dart';
import 'package:assetsync/model/asset_model.dart';
import 'package:assetsync/screens/assets_details.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/assest_tile.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:flutter/material.dart';

class AdminSubAreaAssets extends StatelessWidget {
  final int subAreaId;
  const AdminSubAreaAssets({Key? key, required this.subAreaId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: simpleappbar(),
        backgroundColor: kBGcolor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<AssetModel>>(
              future: SubAreaHelper.getAssest(context, subAreaId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Assets Founded !',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            changeScreen(
                                context,
                                AssetsDetails(
                                    assetModel: snapshot.data![index]));
                          },
                          child: AssetsTitleTile(
                              index: index, title: snapshot.data![index].name),
                        );
                      });
                } else {
                  return const Center(
                    child: Loading(),
                  );
                }
              }),
        ));
  }
}
