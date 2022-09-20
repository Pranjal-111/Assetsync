import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/database/subarea_mysql_helper.dart';
import 'package:assetsync/model/assests_count_model.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/assets_count_tile.dart';
import 'package:assetsync/widgets/error.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubAreaHome extends StatelessWidget {
  const SubAreaHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subAreaModel = BlocProvider.of<GloablAuthCubit>(context).subAreaModel;
    return FutureBuilder<List<AssetsCountModel>>(
      future: SubAreaHelper.getAssetsCount(context, subAreaModel!.subAreaId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Loading());
        }
        if (snapshot.hasError) {
          return const ErrorScreen();
        }
        if (snapshot.data!.length < 2) {
          return Center(
            child: Text(
              'In Sufficent Data To Show Dashnoard',
              textAlign: TextAlign.center,
              style: kHeadingTextStyle,
            ),
          );
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: kGrey,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 1,
                            //   offset: const Offset(10, 10)
                          )
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Countup(
                            begin: 0,
                            end: snapshot.data![0].count + 0.0,
                            style: kHeadingTextStyle,
                            duration: const Duration(seconds: 3),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![0].title,
                            style: kHeadingTextStyle.copyWith(
                                fontWeight: FontWeight.normal, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: kGrey,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 1,
                            //   offset: const Offset(10, 10)
                          )
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Countup(
                            begin: 0,
                            end: snapshot.data![1].count + 0.0,
                            style: kHeadingTextStyle,
                            duration: const Duration(seconds: 4),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![1].title,
                            style: kHeadingTextStyle.copyWith(
                                fontWeight: FontWeight.normal, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return AssetsCountTile(
                    index: index,
                    assetsCountModel: snapshot.data![index],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
