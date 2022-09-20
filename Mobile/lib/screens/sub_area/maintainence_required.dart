import 'dart:io';

import 'package:assetsync/database/subarea_mysql_helper.dart';
import 'package:assetsync/services/custom_sneak_bar.dart';
import 'package:assetsync/utils/constant.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/rounded_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MaintainenceRequired extends StatelessWidget {
  final int assetId;
  const MaintainenceRequired({Key? key, required this.assetId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final blocProvider = BlocProvider.of<GloablAuthCubit>(context);

    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController requirement = TextEditingController();

    final TextEditingController budget = TextEditingController();

    String type = '';
    String proposalLink = '';
    return Scaffold(
      backgroundColor: kBGcolor,
      appBar: simpleappbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
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
                          height: 20,
                        ),
                        Text(
                          "Maintainenece Required",
                          style: kHeadingTextStyle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          radius: 100,
                          backgroundColor: kBGcolor,
                          child: Image.asset(
                            'images/logo.png',
                            height: 150,
                            width: 150,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        DropdownButtonFormField(
                          iconEnabledColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Maintenance Type',
                            hintStyle: const TextStyle(color: kPrimaryColor),
                            prefixIcon: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.privacy_tip,
                                  color: kPrimaryColor,
                                )),
                          ),
                          items: <String>[
                            'Repairement',
                            'Construction',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == "Repairement") {
                              type = value.toString();
                            } else {
                              type = value.toString();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: requirement,
                          maxLines: 3,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Requirement';
                            } else if (value.isEmpty) {
                              return 'Please Enter Requirement';
                            } else {
                              return null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Enter Requirement',
                            hintText: 'Enter Requirement',
                            prefixIcon: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.explore,
                                  color: kPrimaryColor,
                                )),
                          ),
                          keyboardType: TextInputType.multiline,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: budget,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Budget';
                            } else if (value.isEmpty) {
                              return 'Enter Budget Please';
                            } else {
                              return null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Enter Budget',
                            hintText: 'Enter Budget',
                            prefixIcon: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.lock_outlined,
                                  color: kPrimaryColor,
                                )),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf']).then((result) {
                              if (result != null) {
                                proposalLink = result.files.first.path!;
                              } else {
                                showErrorMessage(
                                    context, 'File Not Selected !');
                              }
                            }).onError((error, stackTrace) {
                              showErrorMessage(context,
                                  'Something Went Wrong While Choosing File!');
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Upload Proposal",
                                style: TextStyle(color: kWhite),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        RoundedButton(
                          title: "Submit",
                          onPressed: () async {
                            if (type == '') {
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return const AlertDialog(
                                        title: Text(
                                            "Please select the type of the requirement"));
                                  });
                            } else if (proposalLink == '') {
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return const AlertDialog(
                                        title: Text(
                                            "Please select the Proposal in Pdf Format"));
                                  });
                            } else if (formkey.currentState!.validate()) {
                              final File addFile = await changeFileNameOnly(
                                  File(proposalLink),
                                  'PDF${DateTime.now().microsecondsSinceEpoch}.pdf');

                              await ftpConnect
                                  .connect()
                                  .then((connected) async {
                                if (connected) {
                                  await ftpConnect
                                      .uploadFile(addFile)
                                      .then((uploaded) async {
                                    if (uploaded) {
                                      progressbar(context);
                                      await SubAreaHelper.maintenanceRequired(
                                              context,
                                              assetId,
                                              requirement.text.toString(),
                                              int.parse(budget.text.toString()),
                                              'https://assetsync.tech/assets_images/${addFile.path.split('/').last}',
                                              type.toString())
                                          .then((value) {
                                        if (value == null) {
                                          showErrorMessage(
                                              context, "Something went wrong");
                                        } else {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
                                      });
                                    } else {
                                      showErrorMessage(
                                          context, 'Not Uploaded To Server');
                                      Navigator.pop(context);
                                    }
                                  }).onError((error, stackTrace) {
                                    showErrorMessage(context,
                                        'Some thing Went Wrong $error');
                                    Navigator.pop(context);
                                  });
                                } else {
                                  showErrorMessage(context,
                                      'Enabile To Connect With Server');
                                  Navigator.pop(context);
                                }
                              }).onError((error, stackTrace) {
                                showErrorMessage(
                                    context, 'Some thing Went Wrong $error');
                                Navigator.pop(context);
                              });
                              ftpConnect.disconnect();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }
}
