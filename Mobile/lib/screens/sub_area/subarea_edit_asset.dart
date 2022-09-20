import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/database/subarea_mysql_helper.dart';
import 'package:assetsync/model/asset_model.dart';
import 'package:assetsync/screens/sub_area/pick_image_and_upload.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages

final TextEditingController location = TextEditingController();

class SubAreaEditAsset extends StatefulWidget {
 final AssetModel assetmodel;
  const SubAreaEditAsset({Key? key, required this.assetmodel}) : super(key: key);

  @override
  State<SubAreaEditAsset> createState() => _SubAreaEditAssetState();
}

class _SubAreaEditAssetState extends State<SubAreaEditAsset> {
  @override
  Widget build(BuildContext context) {
    final subAreaModel = BlocProvider.of<GloablAuthCubit>(context).subAreaModel;
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController name = TextEditingController();
    name.text = widget.assetmodel.name;
    final TextEditingController type = TextEditingController();
    type.text = widget.assetmodel.type;

    final TextEditingController owner = TextEditingController();
    owner.text = widget.assetmodel.owner!;

    final TextEditingController size = TextEditingController();
    size.text = widget.assetmodel.size.toString();
    final TextEditingController yoe = TextEditingController();
    yoe.text = widget.assetmodel.year.toString();
    final TextEditingController workingspace = TextEditingController();
    workingspace.text = widget.assetmodel.workingSpace.toString();

    final TextEditingController vacantspace = TextEditingController();
    vacantspace.text = widget.assetmodel.vaccantSpace.toString();
    final TextEditingController floors = TextEditingController();
    floors.text = widget.assetmodel.floors.toString();
    final TextEditingController rooms = TextEditingController();
    rooms.text = widget.assetmodel.rooms.toString();
    final TextEditingController labse = TextEditingController();
    labse.text = widget.assetmodel.labs.toString();
    final TextEditingController capacity = TextEditingController();
    capacity.text = widget.assetmodel.capacity.toString();
    final TextEditingController pob = TextEditingController();
    pob.text = widget.assetmodel.presentUse;

    bool maintance = widget.assetmodel.maintance;
    bool? parking = widget.assetmodel.parking;
    return Scaffold(
      appBar: simpleappbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              "Add Asset Details",
              style: kHeadingTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
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
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Asset Name';
                            } else if (value.length < 3) {
                              return 'Name Should be of 3 Character';
                            } else {
                              return null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Enter Asset Name',
                            hintText: 'Enter Asset Name',
                            prefixIcon: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.edit_calendar,
                                  color: kPrimaryColor,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: size,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Asset size';
                            } else if (value.isEmpty) {
                              return 'Size Should be of 1 Character';
                            } else {
                              return null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Enter Asset Size',
                              hintText: 'Enter Asset Size In Sqaure feet',
                              prefixIcon: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.crop_free,
                                    color: kPrimaryColor,
                                  )),
                              suffixIcon: SizedBox(
                                width: 56,
                                child: Center(
                                  child: Text(
                                    'Sq. ft',
                                    style: kHeadingTextStyle.copyWith(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: capacity,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Asset Capacity';
                            } else if (value.isEmpty) {
                              return 'Capacity Should be of 1 Character';
                            } else {
                              return null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Enter Asset Capacity',
                              hintText: 'Enter Asset Capacity In Liters',
                              prefixIcon: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.chalet,
                                    color: kPrimaryColor,
                                  )),
                              suffixIcon: SizedBox(
                                width: 56,
                                child: Center(
                                  child: Text(
                                    'Liter',
                                    style: kHeadingTextStyle.copyWith(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: pob,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Present use of building';
                            } else if (value.isEmpty) {
                              return 'Should be of 1 Character';
                            } else {
                              return null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Enter Present use',
                            hintText: 'Enter Present use',
                            prefixIcon: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.co_present,
                                  color: kPrimaryColor,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: yoe,
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Asset Year of estalishment';
                            } else if (value.length < 4) {
                              return 'Establishment year Should be of 4 Character';
                            } else {
                              return null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Year of Establishment',
                            hintText: 'Year of Establishment in YYYY',
                            prefixIcon: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.domain_add,
                                  color: kPrimaryColor,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: rooms,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'No. of Rooms';
                            } else if (value.isEmpty) {
                              return 'Rooms Should be of 1 Character';
                            } else {
                              return null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'No. of Rooms',
                            hintText: 'No. of Rooms',
                            prefixIcon: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.meeting_room,
                                  color: kPrimaryColor,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: labse,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'No. of Labs';
                            } else if (value.isEmpty) {
                              return 'Labs Should be of 1 Character';
                            } else {
                              return null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'No. of Labs',
                            hintText: 'No. of Labs',
                            prefixIcon: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.phonelink,
                                  color: kPrimaryColor,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        DropdownButtonFormField(
                          iconEnabledColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Maintence Required',
                            hintStyle: const TextStyle(color: kPrimaryColor),
                            prefixIcon: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.privacy_tip,
                                  color: kPrimaryColor,
                                )),
                          ),
                          items: <String>[
                            'Yes',
                            'No',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == "Yes") {
                              maintance = true;
                            } else {
                              maintance = false;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ExpansionTile(
                          iconColor: kBGcolor,
                          collapsedIconColor: kBGcolor,
                          backgroundColor: kGrey,
                          title: Text(
                            "       Add Additional Details +",
                            textAlign: TextAlign.center,
                            style: kHeadingTextStyle.copyWith(fontSize: 20),
                          ),
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: floors,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'No. of Floors',
                                hintText: 'No. of Floors',
                                prefixIcon: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.apartment,
                                      color: kPrimaryColor,
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: owner,
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Enter Asset Owner',
                                hintText: 'Enter Asset Owner',
                                prefixIcon: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.people,
                                      color: kPrimaryColor,
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: workingspace,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.]'))
                              ],
                              decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Working Space(in %)',
                                  hintText: 'Working Space(in %)',
                                  prefixIcon: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.home_repair_service,
                                        color: kPrimaryColor,
                                      )),
                                  suffixIcon: SizedBox(
                                    width: 56,
                                    child: Center(
                                      child: Text(
                                        '%',
                                        style: kHeadingTextStyle.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: vacantspace,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.]'))
                              ],
                              decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Vacant Space(in %)',
                                  hintText: 'Vacant Space(in %)',
                                  prefixIcon: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.space_bar,
                                        color: kPrimaryColor,
                                      )),
                                  suffixIcon: SizedBox(
                                    width: 56,
                                    child: Center(
                                      child: Text(
                                        '%',
                                        style: kHeadingTextStyle.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            DropdownButtonFormField<String>(
                              iconEnabledColor: kPrimaryColor,
                              style: const TextStyle(color: kPrimaryColor),
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Parking Space',
                                hintStyle:
                                    const TextStyle(color: kPrimaryColor),
                                prefixIcon: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.local_parking,
                                      color: kPrimaryColor,
                                    )),
                              ),
                              items: <String>[
                                'Yes',
                                'No',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value == "Yes") {
                                  parking = true;
                                } else {
                                  parking = false;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                        RoundedButton(
                            title: "Generate",
                            onPressed: () async {
                              // var s = await determinePosition()
                              //     .whenComplete(() {});
                              // var loc =
                              //     decodeLocation(s.latitude, s.longitude);
                              // await loc.then((value) {
                              //   print(value);
                              // });
                              if (formkey.currentState!.validate()) {
                                final AssetModel assetModel = AssetModel(

                                    // id: subAreaModel!.id,
                                    // stateId: subAreaModel.stateId,

                                    id: widget.assetmodel.id,
                                    stateId: subAreaModel!.stateId,
                                    districtId: subAreaModel.districtId,
                                    subAreaId: subAreaModel.subAreaId,
                                    name: name.text,
                                    address: widget.assetmodel.address,
                                    type: widget.assetmodel.type,
                                    size: double.parse(size.text),
                                    capacity: double.parse(capacity.text),
                                    presentUse: pob.text,
                                    year: int.parse(yoe.text),
                                    rooms: int.parse(rooms.text),
                                    labs: int.parse(labse.text),
                                    maintance: maintance,
                                    lon: widget.assetmodel.lon,
                                    lat: widget.assetmodel.lat,
                                    floors: floors.text.isEmpty
                                        ? 0
                                        : int.parse(floors.text),
                                    owner: owner.text.isEmpty ? '' : owner.text,
                                    workingSpace: workingspace.text.isEmpty
                                        ? 0
                                        : double.parse(workingspace.text),
                                    vaccantSpace: vacantspace.text.isEmpty
                                        ? 0
                                        : double.parse(vacantspace.text),
                                    parking: parking);

                                await SubAreaHelper.updateAsset(
                                        context, assetModel)
                                    .then((value) {
                                  changeScreen(
                                      context,
                                      ImagePickAndUpload(
                                        assetId: widget.assetmodel.id,
                                      ));
                                });
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
