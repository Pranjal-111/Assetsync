import 'package:assetsync/database/subarea_mysql_helper.dart';
import 'package:assetsync/model/asset_model.dart';
import 'package:assetsync/screens/sub_area/maintainence_required.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:assetsync/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

class SubAreaAssetsDetails extends StatelessWidget {
  const SubAreaAssetsDetails({Key? key, required this.assetModel})
      : super(key: key);
  final AssetModel assetModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGcolor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return LocateOnMap(lat: assetModel.lat, lon: assetModel.lon);
              });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: kBGcolor,
              boxShadow: [
                BoxShadow(color: kPrimaryColor, blurRadius: 2, spreadRadius: 1)
              ],
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(mainAxisSize: MainAxisSize.min, children: const [
            Icon(
              Icons.location_on_outlined,
              color: kPrimaryColor,
              size: 36,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'View On Map',
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
          ]),
        ),
      ),
      appBar: simpleappbar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: kWhite,
              boxShadow: [
                BoxShadow(color: kPrimaryColor, spreadRadius: 1, blurRadius: 2)
              ],
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            children: [
              const SizedBox(width: double.infinity),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  assetModel.name,
                  style: kHeadingTextStyle,
                ),
              ),
              tableRow('Type', assetModel.type),
              tableRow('Address', assetModel.address),
              if (assetModel.subArea != null)
                tableRow('Sub Area', assetModel.subArea!),
              if (assetModel.district != null)
                tableRow('District', assetModel.district!),
              if (assetModel.state != null)
                tableRow('State', assetModel.state!),
              tableRow('Size', '${assetModel.size} Square Feet'),
              tableRow('Capacity', '${assetModel.capacity} Liter'),
              tableRow('Present Use', assetModel.presentUse),
              tableRow('Year Of Est.', '${assetModel.year}'),
              tableRow('Rooms', '${assetModel.rooms}'),
              tableRow('Labs', '${assetModel.labs}'),
              tableRow('Maintance',
                  assetModel.maintance ? 'Required' : 'Not Required'),
              tableRow('Floors',
                  assetModel.floors == 0 ? 'NA' : '${assetModel.floors}'),
              tableRow(
                  'Owner',
                  assetModel.owner!.isEmpty
                      ? 'NA'
                      : assetModel.owner.toString()),
              tableRow(
                  'Working Space',
                  assetModel.workingSpace == 0.0
                      ? 'NA'
                      : '${assetModel.workingSpace} %'),
              tableRow(
                  'Vaccant Space',
                  assetModel.vaccantSpace == 0.0
                      ? 'NA'
                      : '${assetModel.vaccantSpace} %'),
              tableRow('Parking', assetModel.parking == true ? 'Yes' : 'No'),
              tableRow('Images', ''),
              RoundedButton(
                  title: "Add Maintainence",
                  onPressed: () {
                    changeScreen(
                        context,
                        MaintainenceRequired(
                          assetId: assetModel.id,
                        ));
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<List<String>>(
                    future: SubAreaHelper.getImages(context, assetModel.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Loading();
                      }
                      if (snapshot.data!.isEmpty) {
                        return Container(
                          margin: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              color: kWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              boxShadow: [
                                BoxShadow(
                                    color: kPrimaryColor,
                                    spreadRadius: 2,
                                    blurRadius: 1)
                              ]),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.broken_image_outlined,
                                  color: kPrimaryColor,
                                  size: MediaQuery.of(context).size.width / 2,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  'No Image Available',
                                  style: kHeadingTextStyle,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                                height: MediaQuery.of(context).size.width / 1.2,
                                margin: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: kPrimaryColor,
                                          spreadRadius: 2,
                                          blurRadius: 1)
                                    ]),
                                child: Image.network(
                                  (snapshot.data![index]),
                                ));
                          });
                    }),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding tableRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                '$title :',
                style: const TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              )),
          Expanded(
              flex: 2,
              child: Text(
                value,
                style: const TextStyle(color: kPrimaryColor),
              ))
        ],
      ),
    );
  }
}

class LocateOnMap extends StatelessWidget {
  final double lat;
  final double lon;

  const LocateOnMap({Key? key, required this.lat, required this.lon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View on Map"),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: const Icon(
          Icons.baby_changing_station,
          color: kPrimaryColor,
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(lat, lon),
          zoom: 13,
        ),
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
