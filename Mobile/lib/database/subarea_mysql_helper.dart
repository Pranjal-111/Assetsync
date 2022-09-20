import 'dart:convert';

import 'package:assetsync/model/assests_count_model.dart';
import 'package:assetsync/model/asset_model.dart';
import 'package:assetsync/model/subarea_model.dart';
import 'package:assetsync/services/custom_sneak_bar.dart';
import 'package:assetsync/utils/constant.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class SubAreaHelper {
  static Future<SubAreaModel?> login(
      BuildContext context, String username, String password) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) async {
      return await conn.query(
          'select * from admin,states ,district, sub_area WHERE admin.id = sub_area.admin_id AND district.id = sub_area.district_id AND states.id = sub_area.state_id AND admin.username = ?',
          [username]).then((value) {
        if (value.isEmpty) {
          showErrorMessage(context, 'No user Exists');
          return null;
        } else {
          final hmacSha256 = Hmac(sha256, secretKey); // HMAC-SHA256
          final passwordDigest =
              hmacSha256.convert(utf8.encode(password)).toString();
          if (value.first['password'] != passwordDigest) {
            showErrorMessage(context, 'Wrong Password');
            return null;
          } else {
            showSuccessMessage(context, 'Login SucessFully');
            return SubAreaModel(
                id: value.first['admin_id'],
                name: value.first['name'],
                email: value.first['email'],
                phone: value.first['phone'],
                password: value.first['password'],
                username: value.first['username'],
                stateId: value.first['state_id'],
                districtId: value.first['district_id'],
                subAreaId: value.first['id']);
          }
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());
        return null;
      });
    });
  }

  static Future<SubAreaModel?> getUser(int id) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query(
          'select * from admin,states ,district, sub_area WHERE admin.id = sub_area.admin_id AND district.id = sub_area.district_id AND states.id = sub_area.state_id AND admin.id= ?',
          [id]).then((value) {
        if (value.isEmpty) {
          return null;
        } else {
          return SubAreaModel(
              id: value.first['admin_id'],
              name: value.first['name'],
              email: value.first['email'],
              phone: value.first['phone'],
              password: value.first['password'],
              username: value.first['username'],
              stateId: value.first['state_id'],
              districtId: value.first['district_id'],
              subAreaId: value.first['id']);
        }
      }).onError((error, stackTrace) {
        return null;
      });
    });
  }

  static Future<List<AssetsCountModel>> getAssetsCount(
      BuildContext context, int subAreaID) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query(
          'SELECT type,COUNt(*) as count  FROM `asset` WHERE asset.sub_area_id = ? and `isApproved` = true GROUP by type ORDER BY COUNT(*) DESC;',
          [subAreaID]).then((value) {
        if (value.isEmpty) {
          return <AssetsCountModel>[];
        } else {
          List<AssetsCountModel> result = [];

          for (var raw in value) {
            result
                .add(AssetsCountModel(title: raw['type'], count: raw['count']));
          }
          return result;
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());

        return <AssetsCountModel>[];
      });
    });
  }

  static Future<int?> addAssets(
      BuildContext context, AssetModel assetModel) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) async {
      return await conn.query(
          'INSERT INTO `asset` (`id`, `state_id`, `district_id`, `sub_area_id`, `name`, `type`, `address`, `size`, `capacity`, `present_use`, `yaer_of_est`, `rooms`, `labs`, `maintance`, `floors`, `owner`, `working_space`, `vaccant_space`, `parking`, `lon`, `lat`) VALUES (NULL, ? , ? , ? , ? , ? , ? , ?, ? , ? , ? , ?  , ? , ? , ? , ? , ? , ? , ? , ? ,?)',
          [
            assetModel.stateId,
            assetModel.districtId,
            assetModel.subAreaId,
            assetModel.name,
            assetModel.type,
            assetModel.address,
            assetModel.size,
            assetModel.capacity,
            assetModel.presentUse,
            assetModel.year,
            assetModel.rooms,
            assetModel.labs,
            assetModel.maintance,
            assetModel.floors,
            assetModel.owner,
            assetModel.workingSpace,
            assetModel.vaccantSpace,
            assetModel.parking,
            assetModel.lon,
            assetModel.lat
          ]).then((value) {
        showSuccessMessage(context, 'Assets Addes Sucessfully');
        return value.insertId;
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());
        return null;
      });
    }).onError((error, stackTrace) {
      showErrorMessage(context, error.toString());
      return null;
    });
  }

  static Future<int?> maintenanceRequired(BuildContext context, int assetId,
      String req, int budg, String prop, String typ) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) async {
      return await conn.query(
          'insert into `maintain`(`id`,`asset_id`,`requirement`,`budget`,`proposal`,`type`)Values (NULL,?,?,?,?,?)',
          [assetId, req, budg, prop, typ]).then((value) {
        showSuccessMessage(context, 'Assets Maintenance Applied');
        return value.insertId;
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());
        return null;
      });
    }).onError((error, stackTrace) {
      showErrorMessage(context, error.toString());
      return null;
    });
  }

  static Future<void> addImages(
      BuildContext context, int assetId, String imgaeName) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) async {
      return await conn.query(
          'INSERT INTO `asset_images` (`image_id`, `asset_id`, `image_name`) VALUES (NULL, ? , ?);',
          [assetId, imgaeName]).then((value) {
        showSuccessMessage(context, 'Assets Addes Sucessfully');
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());
      });
    }).onError((error, stackTrace) {
      showErrorMessage(context, error.toString());
    });
  }

//Updation of asset and it will get to the district
  static Future<void> updateAsset(
      BuildContext context, AssetModel assetModel) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) async {
      return await conn.query(
          'UPDATE `asset` SET `name`= ?,`size`= ? ,`capacity`= ? ,`present_use`= ? ,`yaer_of_est`= ? ,`rooms`= ? ,`labs`= ? ,`maintance`= ? ,`floors`= ? ,`owner`= ? ,`working_space`= ? ,`vaccant_space`= ? ,`parking`= ? ,`isApproved`= NUll WHERE asset.id = ?',
          [
            assetModel.name,
            assetModel.size,
            assetModel.capacity,
            assetModel.presentUse,
            assetModel.year,
            assetModel.rooms,
            assetModel.labs,
            assetModel.maintance,
            assetModel.floors,
            assetModel.owner,
            assetModel.workingSpace,
            assetModel.vaccantSpace,
            assetModel.parking,
            assetModel.id
          ]).then((value) {
        showSuccessMessage(context, 'Assets Added Sucessfully');
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());
      });
    }).onError((error, stackTrace) {
      showErrorMessage(context, error.toString());
    });
  }

  static Future<List<AssetModel>> getAssest(
      BuildContext context, int subAreaId) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query(
          'SELECT * FROM `asset` WHERE asset.sub_area_id = ? and   `isApproved` = true',
          [subAreaId]).then((value) {
        if (value.isEmpty) {
          return <AssetModel>[];
        } else {
          List<AssetModel> result = [];

          for (var raw in value) {
            result.add(AssetModel(
                id: raw['id'],
                stateId: raw['state_id'],
                districtId: raw['district_id'],
                subAreaId: raw['sub_area_id'],
                name: raw['name'],
                address: raw['address'],
                type: raw['type'],
                size: raw['size'],
                capacity: raw['capacity'],
                presentUse: raw['present_use'],
                year: raw['yaer_of_est'],
                rooms: raw['rooms'],
                labs: raw['labs'],
                maintance: raw['maintance'] == 0 ? true : false,
                floors: raw['floors'],
                owner: raw['owner'],
                workingSpace: raw['working_space'],
                vaccantSpace: raw['working_space'],
                lon: raw['lon'],
                lat: raw['lat']));
          }
          return result;
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());

        return <AssetModel>[];
      });
    });
  }

  static Future<List<String>> getImages(
      BuildContext context, int assetId) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query('SELECT * FROM `asset_images` WHERE asset_id = ? ',
          [assetId]).then((value) {
        if (value.isEmpty) {
          return <String>[];
        } else {
          List<String> result = [];

          for (var raw in value) {
            result.add(
                '${raw['image_name']}');
          }
          return result;
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());

        return <String>[];
      });
    });
  }
}
