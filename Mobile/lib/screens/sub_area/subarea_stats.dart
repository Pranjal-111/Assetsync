import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/database/subarea_mysql_helper.dart';
import 'package:assetsync/model/asset_model.dart';
import 'package:assetsync/screens/sub_area/subarea_asset_detail.dart';
import 'package:assetsync/screens/sub_area/subarea_edit_asset.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/asset_tile_edit.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubAreaStats extends StatelessWidget {
  const SubAreaStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subAreaModel = BlocProvider.of<GloablAuthCubit>(context).subAreaModel;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<AssetModel>>(
          future: SubAreaHelper.getAssest(context, subAreaModel!.subAreaId),
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
                            SubAreaAssetsDetails(
                                assetModel: snapshot.data![index]));
                      },
                      child: AssetsTitleEdit(
                          tap: () {
                            changeScreen(
                                context,
                                SubAreaEditAsset(
                                  assetmodel: snapshot.data![index],
                                ));
                          },
                          index: index,
                          title: snapshot.data![index].name),
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
