import 'package:assetsync/database/admin_mysql_helper.dart';
import 'package:assetsync/model/state_model.dart';
import 'package:assetsync/screens/admin/admin_add_state.dart';
import 'package:assetsync/screens/admin/admin_district_list.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/error.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:assetsync/widgets/state_tile.dart';
import 'package:flutter/material.dart';

class AdminAdministration extends StatelessWidget {
  const AdminAdministration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGcolor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          changeScreen(context, const AdminAddState());
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          color: kWhite,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<StateModel>>(
            future: AdminMySQLHelper.getStates(context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const ErrorScreen();
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No State Added',
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
                      return StateTile(ontap: (){
                                       changeScreen(
                    context,
                    AdminDistrictList(
                      stateId: snapshot.data![index].stateId,
                    ));
                      },
                          index: index, stateModel: snapshot.data![index]);
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
