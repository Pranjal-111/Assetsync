import 'package:assetsync/database/district_mysql_helper.dart';
import 'package:assetsync/model/subarea_model.dart';
import 'package:assetsync/screens/admin/admin_sub_area_assets.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:assetsync/widgets/subarea_tile.dart';
import 'package:flutter/material.dart';

class AdminSubAreaList extends StatelessWidget {
  final int districtid;
  const AdminSubAreaList({Key? key, required this.districtid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleappbar(),
      backgroundColor: kBGcolor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<SubAreaModel>>(
            future: DistrictMySqlHelper.getSubArea(context, districtid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Sub Area Added',
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
                      return SubAreaTile(
                          ontap: () {
                            changeScreen(
                                context,
                                AdminSubAreaAssets(
                                    subAreaId:
                                        snapshot.data![index].subAreaId));
                          },
                          index: index,
                          subAreaModel: snapshot.data![index]);
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
