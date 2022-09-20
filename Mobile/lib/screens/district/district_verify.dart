import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/database/district_mysql_helper.dart';
import 'package:assetsync/model/asset_model.dart';
import 'package:assetsync/screens/district/district_verify_asset_detail.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/asset_verification_tile.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistrictVerify extends StatelessWidget {
  const DistrictVerify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final districtModel =
        BlocProvider.of<GloablAuthCubit>(context).districtModel;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<AssetModel>>(
          future: DistrictMySqlHelper.getAssestforverification(
              context, districtModel!.districtId),
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
                        changeScreen(
                            context,
                            DistrictVerifyDetail(
                                assetModel: snapshot.data![index]));
                      },
                      child: AssetVerificationTile(
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
