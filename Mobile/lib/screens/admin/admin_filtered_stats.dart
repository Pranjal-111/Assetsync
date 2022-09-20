import 'package:assetsync/database/admin_mysql_helper.dart';
import 'package:assetsync/model/asset_model.dart';
import 'package:assetsync/screens/assets_details.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/assest_tile.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:flutter/material.dart';

class AdminFilteredStats extends StatelessWidget {
  final String query;
  const AdminFilteredStats({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGcolor,
      appBar: simpleappbar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<AssetModel>>(
            future: AdminMySQLHelper.getAssest(context, query),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Assets Found !',
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
                          changeScreen(context,
                              AssetsDetails(assetModel: snapshot.data![index]));
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
      ),
    );
  }
}
