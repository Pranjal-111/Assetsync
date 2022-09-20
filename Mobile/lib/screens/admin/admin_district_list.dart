import 'package:assetsync/database/state_mysql_helper.dart';
import 'package:assetsync/model/district_model.dart';
import 'package:assetsync/screens/admin/admin_sub_area_list.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/district_tile.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:flutter/material.dart';

class AdminDistrictList extends StatelessWidget {
  final int stateId;
  const AdminDistrictList({Key? key, required this.stateId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleappbar(),
      backgroundColor: kBGcolor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<DistrictModel>>(
            future: StateMySQLHelper.getDistrict(context, stateId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No District Added',
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
                      return DistrictTile(
                          ontap: () {
                            changeScreen(
                                context,
                                AdminSubAreaList(
                                    districtid:
                                        snapshot.data![index].districtId));
                          },
                          index: index,
                          districtModel: snapshot.data![index]);
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
