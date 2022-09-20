import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/database/state_mysql_helper.dart';
import 'package:assetsync/model/maintance_model.dart';
import 'package:assetsync/screens/state/state_maintance_details.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/assest_tile.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StateMaintenanceRequest extends StatelessWidget {
  const StateMaintenanceRequest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stateModel = BlocProvider.of<GloablAuthCubit>(context).stateModel;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<MaintanceModel>>(
          future:
              StateMySQLHelper.getAssestRequestes(context, stateModel!.stateId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No Maintenance Request Found !',
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
                            StateMaitanceDetails(
                                maintanceModel: snapshot.data![index]));
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
    );
  }
}
