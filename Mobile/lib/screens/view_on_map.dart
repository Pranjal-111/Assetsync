import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class ViewOnMap extends StatelessWidget {
  const ViewOnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController name = TextEditingController();
    final TextEditingController type = TextEditingController();
    final TextEditingController location = TextEditingController();
    final TextEditingController owner = TextEditingController();
    final TextEditingController size = TextEditingController();
    final TextEditingController yoe = TextEditingController();
    final TextEditingController workingspace = TextEditingController();
    final TextEditingController vacantspace = TextEditingController();
    final TextEditingController floors = TextEditingController();
    final TextEditingController rooms = TextEditingController();
    final TextEditingController labse = TextEditingController();

    return Scaffold(
        backgroundColor: kBGcolor,
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
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
                            controller: type,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Asset Type';
                              } else if (value.length < 3) {
                                return 'Type Should be of 3 Character';
                              } else {
                                return null;
                              }
                            },
                            decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Enter Asset Type',
                              hintText: 'Enter Asset Type',
                              prefixIcon: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.list,
                                    color: kPrimaryColor,
                                  )),
                            ),
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
                              hintText: 'Enter Asset Size',
                              prefixIcon: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.crop_free,
                                    color: kPrimaryColor,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            controller: floors,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'No. of Floors';
                              } else if (value.isEmpty) {
                                return 'Floor Should be of 1 Character';
                              } else {
                                return null;
                              }
                            },
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
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            controller: rooms,
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
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            controller: labse,
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
                            keyboardType: TextInputType.number,
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
                            onChanged: (value) {},
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
                              TextFormField(
                                controller: owner,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Asset Owner';
                                  } else if (value.length < 3) {
                                    return 'Owner Should be of 3 Character';
                                  } else {
                                    return null;
                                  }
                                },
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
                                controller: yoe,
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
                                  hintText: 'Year of Establishment',
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
                                // controller: name,
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
                                  labelText: 'Enter Images',
                                  hintText: 'Enter Images',
                                  prefixIcon: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.image,
                                        color: kPrimaryColor,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: workingspace,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Working Space';
                                  } else if (value.length < 4) {
                                    return 'Working Space Should be of 4 Character';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Working Space(in %)',
                                  hintText: 'Working Space(in %)',
                                  prefixIcon: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.home_repair_service,
                                        color: kPrimaryColor,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: vacantspace,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Vacant Space';
                                  } else if (value.length < 4) {
                                    return 'Vacant Space Should be of 4 Character';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Vacant Space(in %)',
                                  hintText: 'Vacant Space(in %)',
                                  prefixIcon: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.space_bar,
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
                                onChanged: (value) {},
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                          RoundedButton(title: "Generate", onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
