import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/database/district_mysql_helper.dart';
import 'package:assetsync/model/subarea_model.dart';
import 'package:assetsync/screens/district/district_add_admin.dart';
import 'package:assetsync/screens/district/district_sub_area_assets.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:assetsync/widgets/subarea_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistrictAdministration extends StatelessWidget {
  const DistrictAdministration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<GloablAuthCubit>(context);
    return Scaffold(
      backgroundColor: kBGcolor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          changeScreen(context, const DistrictAddAdmin());
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          color: kWhite,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<SubAreaModel>>(
            future: DistrictMySqlHelper.getSubArea(
                context, blocProvider.districtModel!.districtId),
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
                                DistrictSubAreaAssets(
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
