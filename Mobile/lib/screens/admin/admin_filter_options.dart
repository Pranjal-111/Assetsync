import 'package:assetsync/database/admin_mysql_helper.dart';
import 'package:assetsync/database/district_mysql_helper.dart';
import 'package:assetsync/database/state_mysql_helper.dart';
import 'package:assetsync/model/assests_count_model.dart';
import 'package:assetsync/model/district_model.dart';
import 'package:assetsync/model/state_model.dart';
import 'package:assetsync/model/subarea_model.dart';
import 'package:assetsync/screens/admin/admin_filtered_stats.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/services/custom_sneak_bar.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:assetsync/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class AdminFilterOption extends StatefulWidget {
  const AdminFilterOption({Key? key}) : super(key: key);

  @override
  State<AdminFilterOption> createState() => _AdminFilterOptionState();
}

class _AdminFilterOptionState extends State<AdminFilterOption> {
  String? type;
  int stateId = -1;
  int districtId = -1;
  int subAreaId = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGcolor,
      appBar: simpleappbar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FutureBuilder<List<AssetsCountModel>>(
                future: AdminMySQLHelper.getAssetsCount(
                  context,
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Loading());
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      iconEnabledColor: kPrimaryColor,
                      style: const TextStyle(color: kPrimaryColor),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Select Category',
                        hintStyle: const TextStyle(color: kPrimaryColor),
                        prefixIcon: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.category,
                              color: kPrimaryColor,
                            )),
                      ),
                      items: snapshot.data!.map((AssetsCountModel value) {
                        return DropdownMenuItem<String>(
                          value: value.title,
                          child: Text(value.title),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          type = value.toString();
                          stateId = -1;
                          districtId = -1;
                          subAreaId = -1;
                        });
                      },
                    ),
                  );
                }),
            FutureBuilder<List<StateModel>>(
                future: AdminMySQLHelper.getStates(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Loading());
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      iconEnabledColor: kPrimaryColor,
                      style: const TextStyle(color: kPrimaryColor),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Select State',
                        hintStyle: const TextStyle(color: kPrimaryColor),
                        prefixIcon: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.location_city,
                              color: kPrimaryColor,
                            )),
                      ),
                      items: snapshot.data!.map((StateModel value) {
                        return DropdownMenuItem<String>(
                          value: value.stateId.toString(),
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          stateId = int.parse(value.toString());
                          districtId = -1;
                          subAreaId = -1;
                        });
                      },
                    ),
                  );
                }),
            FutureBuilder<List<DistrictModel>>(
                future: StateMySQLHelper.getDistrict(context, stateId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Loading());
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      iconEnabledColor: kPrimaryColor,
                      style: const TextStyle(color: kPrimaryColor),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Select District',
                        hintStyle: const TextStyle(color: kPrimaryColor),
                        prefixIcon: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.area_chart,
                              color: kPrimaryColor,
                            )),
                      ),
                      items: snapshot.data!.map((DistrictModel value) {
                        return DropdownMenuItem<String>(
                          value: value.districtId.toString(),
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          districtId = int.parse(value.toString());
                          subAreaId = -1;
                        });
                      },
                    ),
                  );
                }),
            FutureBuilder<List<SubAreaModel>>(
                future: DistrictMySqlHelper.getSubArea(context, districtId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Loading());
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      iconEnabledColor: kPrimaryColor,
                      style: const TextStyle(color: kPrimaryColor),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Select Sub Area',
                        hintStyle: const TextStyle(color: kPrimaryColor),
                        prefixIcon: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.home,
                              color: kPrimaryColor,
                            )),
                      ),
                      items: snapshot.data!.map((SubAreaModel value) {
                        return DropdownMenuItem<String>(
                          value: value.subAreaId.toString(),
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        subAreaId = int.parse(value.toString());
                      },
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 108),
              child: RoundedButton(
                  title: 'Apply',
                  onPressed: () {
                    String query = '';

                    if (type != null) {
                      query = '$query WHERE asset.type = \'$type\' ';

                      if (stateId != -1) {
                        query = '$query And asset.state_id = $stateId ';
                        if (districtId != -1) {
                          query = '$query AND asset.district_id = $districtId';
                          if (subAreaId != -1) {
                            query = '$query AND asset.sub_area_id = $subAreaId';
                          }
                        }
                      }
                    } else {
                      if (stateId != -1) {
                        query = '$query WHERE asset.state_id = $stateId ';
                        if (districtId != -1) {
                          query = '$query AND asset.district_id = $districtId';
                          if (subAreaId != -1) {
                            query = '$query AND asset.sub_area_id = $subAreaId';
                          }
                        }
                      }
                    }

                    if (query == '') {
                      showErrorMessage(
                          context, 'Please Select Atleast One Option');
                    } else {
                      changeScreen(context, AdminFilteredStats(query: query));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
