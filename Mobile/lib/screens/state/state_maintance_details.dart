import 'package:assetsync/database/state_mysql_helper.dart';
import 'package:assetsync/model/maintance_model.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class StateMaitanceDetails extends StatelessWidget {
  const StateMaitanceDetails({Key? key, required this.maintanceModel})
      : super(key: key);
  final MaintanceModel maintanceModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGcolor,
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
                  maintanceModel.name,
                  style: kHeadingTextStyle,
                ),
              ),
              tableRow('District', maintanceModel.district!),
              tableRow('Sub Area', maintanceModel.subArea!),

              tableRow('MaintenanceType', maintanceModel.type),
              tableRow('Requiremnet', maintanceModel.requirement),
              tableRow('Budget ₹ ', maintanceModel.budget.toString()),

              tableRow('Proposal', ''),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 72),
                child: RoundedButton(
                    title: 'View Proposal',
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isDismissible: true,
                          enableDrag: false,
                          builder: (context) {
                            return SfPdfViewer.network(maintanceModel.proposal);
                          });
                    }),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      StateMySQLHelper.maintenanceVerification(
                          context, maintanceModel.id, true);
                    },
                    child: const Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 48,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      StateMySQLHelper.maintenanceVerification(
                          context, maintanceModel.id, false);
                    },
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 48,
                    ),
                  )
                ],
              ),

              // SizedBox(
              //   height: MediaQuery.of(context).size.width,
              //   width: MediaQuery.of(context).size.width,
              //   child: FutureBuilder<List<String>>(
              //       future: SubAreaHelper.getImages(context, maintanceModel.id),
              //       builder: (context, snapshot) {
              //         if (!snapshot.hasData) {
              //           return const Loading();
              //         }
              //         if (snapshot.data!.isEmpty) {
              //           return Container(
              //             margin: const EdgeInsets.all(16),
              //             decoration: const BoxDecoration(
              //                 color: kWhite,
              //                 borderRadius:
              //                     BorderRadius.all(Radius.circular(4)),
              //                 boxShadow: [
              //                   BoxShadow(
              //                       color: kPrimaryColor,
              //                       spreadRadius: 2,
              //                       blurRadius: 1)
              //                 ]),
              //             child: Center(
              //               child: Column(
              //                 mainAxisSize: MainAxisSize.min,
              //                 children: [
              //                   Icon(
              //                     Icons.broken_image_outlined,
              //                     color: kPrimaryColor,
              //                     size: MediaQuery.of(context).size.width / 2,
              //                   ),
              //                   const SizedBox(
              //                     height: 50,
              //                   ),
              //                   Text(
              //                     'No Image Available',
              //                     style: kHeadingTextStyle,
              //                   )
              //                 ],
              //               ),
              //             ),
              //           );
              //         }
              //         return ListView.builder(
              //             scrollDirection: Axis.horizontal,
              //             itemCount: snapshot.data!.length,
              //             itemBuilder: (context, index) {
              //               return Container(
              //                   height: MediaQuery.of(context).size.width / 1.2,
              //                   margin: const EdgeInsets.all(16),
              //                   decoration: const BoxDecoration(
              //                       borderRadius:
              //                           BorderRadius.all(Radius.circular(4)),
              //                       boxShadow: [
              //                         BoxShadow(
              //                             color: kPrimaryColor,
              //                             spreadRadius: 2,
              //                             blurRadius: 1)
              //                       ]),
              //                   child: Image.network(
              //                     (snapshot.data![index]),
              //                   ));
              //             });
              //       }),
              // ),
              // const SizedBox(
              //   height: 30,
              // )

              const SizedBox(height: 10),
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
