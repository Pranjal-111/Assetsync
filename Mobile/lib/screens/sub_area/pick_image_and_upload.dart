import 'dart:io';

import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/database/subarea_mysql_helper.dart';
import 'package:assetsync/services/custom_sneak_bar.dart';
import 'package:assetsync/utils/constant.dart';
import 'package:assetsync/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickAndUpload extends StatefulWidget {
  const ImagePickAndUpload({Key? key, required this.assetId}) : super(key: key);
  final int assetId;

  @override
  State<ImagePickAndUpload> createState() => _ImagePickAndUploadState();
}

class _ImagePickAndUploadState extends State<ImagePickAndUpload> {
  List<File> imagesList = [];

  @override
  void dispose() {
    ftpConnect.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subAreaModel = BlocProvider.of<GloablAuthCubit>(context).subAreaModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Center(
          child: Text('Add Images'),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await ftpConnect.connect().then((connected) async {
                if (connected) {
                  for (File file in imagesList) {
                    await ftpConnect.uploadFile(file).then((uploaded) async {
                      if (uploaded) {
                        await SubAreaHelper.addImages(context, widget.assetId,
                                'https://assetsync.tech/assets_images/${file.path.split('/').last}')
                            .then((value) {
                          showSuccessMessage(
                              context, 'Image Uploaded Sucessfully');
                        }).onError((error, stackTrace) {
                          showErrorMessage(
                              context, 'Some thing Went Wrong $error');
                        });
                      } else {
                        showErrorMessage(context, 'Not Uploaded To Server');
                      }
                    }).onError((error, stackTrace) {
                      showErrorMessage(context, 'Some thing Went Wrong $error');
                    });
                  }
                  Navigator.pop(context);
                } else {
                  showErrorMessage(context, 'Enabile To Connect With Server');
                }
              }).onError((error, stackTrace) {
                showErrorMessage(context, 'Some thing Went Wrong $error');
              });
              ftpConnect.disconnect();
            },
            child: const SizedBox(
                height: 58,
                width: 58,
                child: Icon(
                  Icons.check_circle,
                  size: 32,
                )),
          )
        ],
      ),
      backgroundColor: kBGcolor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () async {
          ImagePicker()
              .pickImage(source: ImageSource.gallery)
              .then((value) async {
            final File addFile = await changeFileNameOnly(File(value!.path),
                '${subAreaModel!.stateId}${subAreaModel.districtId}${subAreaModel.id}image${DateTime.now().microsecondsSinceEpoch}.png');
            imagesList.add(addFile);
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
      body: imagesList.isEmpty
          ? const Center(
              child: Icon(
                Icons.add_photo_alternate,
                color: kPrimaryColor,
                size: 300,
              ),
            )
          : ListView.builder(
              itemCount: imagesList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      boxShadow: [
                        BoxShadow(
                            color: kPrimaryColor,
                            spreadRadius: 2,
                            blurRadius: 1)
                      ]),
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            boxShadow: [
                              BoxShadow(
                                  color: kPrimaryColor,
                                  spreadRadius: 2,
                                  blurRadius: 1)
                            ]),
                        child: Image.file(
                          imagesList[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                imagesList.removeAt(index);
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundColor: kPrimaryColor,
                                  child: Icon(
                                    Icons.delete,
                                    color: kWhite,
                                  )),
                            ),
                          )),
                    ],
                  ),
                );
              }),
    );
  }

  Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }
}
