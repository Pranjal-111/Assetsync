import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/database/state_mysql_helper.dart';
import 'package:assetsync/model/district_model.dart';
import 'package:assetsync/screens/state/state_sub_area_list.dart';
import 'package:assetsync/screens/state/state_add_district.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/district_tile.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StateAdministration extends StatelessWidget {
  const StateAdministration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<GloablAuthCubit>(context);
    return Scaffold(
      backgroundColor: kBGcolor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          changeScreen(context, const StateAddDistrict());
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          color: kWhite,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<DistrictModel>>(
            future: StateMySQLHelper.getDistrict(
                context, blocProvider.stateModel!.stateId),
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
                                StateSubAreaList(
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
