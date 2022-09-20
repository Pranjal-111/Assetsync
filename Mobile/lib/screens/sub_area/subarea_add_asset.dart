import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/database/subarea_mysql_helper.dart';
import 'package:assetsync/model/asset_model.dart';
import 'package:assetsync/screens/sub_area/pick_image_and_upload.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/services/custom_sneak_bar.dart';
import 'package:assetsync/services/location_service.dart';
import 'package:assetsync/utils/constant.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

late double lat;
late double lon;

final TextEditingController location = TextEditingController();

class SubAreaAddAsset extends StatefulWidget {
  const SubAreaAddAsset({Key? key}) : super(key: key);

  @override
  State<SubAreaAddAsset> createState() => _SubAreaAddAssetState();
}

class _SubAreaAddAssetState extends State<SubAreaAddAsset> {
  @override
  void initState() {
    locationput();
    super.initState();
  }

  void locationput() async {
    var s = await determinePosition().whenComplete(() {});
    var loc = decodeLocation(s.latitude, s.longitude);
    lat = s.latitude;
    lon = s.longitude;
    await loc.then((value) {
      location.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final subAreaModel = BlocProvider.of<GloablAuthCubit>(context).subAreaModel;
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController name = TextEditingController();
    final TextEditingController type = TextEditingController();

    final TextEditingController owner = TextEditingController();
    final TextEditingController size = TextEditingController();
    final TextEditingController yoe = TextEditingController();
    final TextEditingController workingspace = TextEditingController();
    final TextEditingController vacantspace = TextEditingController();
    final TextEditingController floors = TextEditingController();
    final TextEditingController rooms = TextEditingController();
    final TextEditingController labse = TextEditingController();
    final TextEditingController capacity = TextEditingController();
    final TextEditingController pob = TextEditingController();
    bool maintance = false;
    bool parking = false;
    return SingleChildScrollView(
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
                      DropdownButtonFormField<String>(
                        iconEnabledColor: kPrimaryColor,
                        style: const TextStyle(color: kPrimaryColor),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Asset Type',
                          hintStyle: const TextStyle(color: kPrimaryColor),
                          prefixIcon: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.list,
                                color: kPrimaryColor,
                              )),
                        ),
                        items: assetType.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          type.text = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: location,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Asset Location';
                          } else if (value.length < 3) {
                            return 'Location Should be of 3 Character';
                          } else {
                            return null;
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Enter Asset Location',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (builder) {
                                    return const MarkonMap();
                                  });
                            },
                            child: const Icon(Icons.arrow_circle_right,
                                color: kPrimaryColor),
                          ),
                          hintText: 'Enter Asset Location',
                          prefixIcon: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.location_on,
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
                              hintStyle: const TextStyle(color: kPrimaryColor),
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
                                  id: 1,
                                  stateId: subAreaModel!.stateId,
                                  districtId: subAreaModel.districtId,
                                  subAreaId: subAreaModel.subAreaId,
                                  name: name.text,
                                  address: location.text,
                                  type: type.text,
                                  size: double.parse(size.text),
                                  capacity: double.parse(capacity.text),
                                  presentUse: pob.text,
                                  year: int.parse(yoe.text),
                                  rooms: int.parse(rooms.text),
                                  labs: int.parse(labse.text),
                                  maintance: maintance,
                                  lon: lon,
                                  lat: lat,
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

                              await SubAreaHelper.addAssets(context, assetModel)
                                  .then((insertId) {
                                if (insertId != null) {
                                  changeScreen(
                                      context,
                                      ImagePickAndUpload(
                                        assetId: insertId,
                                      ));
                                } else {
                                  showErrorMessage(
                                      context, 'Assest is Not Added');
                                }
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
    );
  }
}

class MarkonMap extends StatefulWidget {
  const MarkonMap({Key? key}) : super(key: key);

  @override
  State<MarkonMap> createState() => _MarkonMapState();
}

class _MarkonMapState extends State<MarkonMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mark on Map"),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: const Icon(
          Icons.add,
          color: kPrimaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () async {
          progressbar(context);
          var loc = decodeLocation(lat, lon);
          await loc.then((value) {
            location.text = value;
            Navigator.pop(context);
            Navigator.pop(context);
          });
        },
        child: Container(
          decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Mark the Location +",
              style: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
            onTap: ((tapPosition, point) {
              setState(() {
                lon = point.longitude;
                lat = point.latitude;
              });
            }),
            center: LatLng(lat, lon),
            zoom: 13,
            maxBounds: LatLngBounds(
              LatLng(lat + 1, lon + 1),
              LatLng(lat - 1, lon - 1),
            )),
        layers: [
          TileLayerOptions(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/pranjalaggarwal123/cl5labtao004a14s0vt1ozr15/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicHJhbmphbGFnZ2Fyd2FsMTIzIiwiYSI6ImNsNzAwcHBvdzA5d20zdm95aDY5c3Y0enMifQ.F2_KjoMmiw-jxjI9Z0uo9A',
              additionalOptions: {
                'token':
                    'pk.eyJ1IjoicHJhbmphbGFnZ2Fyd2FsMTIzIiwiYSI6ImNsNzAwcHBvdzA5d20zdm95aDY5c3Y0enMifQ.F2_KjoMmiw-jxjI9Z0uo9A',
                'id': 'mapbox.mapbox-streets-v8',
              }),
          MarkerLayerOptions(markers: [
            Marker(
                point: LatLng(lat, lon),
                builder: (builder) {
                  return Icon(Icons.location_on, color: Colors.red.shade900);
                })
          ])
        ],
      ),
    );
  }
}
