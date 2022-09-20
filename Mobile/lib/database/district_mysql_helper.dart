import 'dart:convert';

import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/model/assests_count_model.dart';
import 'package:assetsync/model/asset_model.dart';
import 'package:assetsync/model/district_model.dart';
import 'package:assetsync/model/maintance_model.dart';
import 'package:assetsync/model/subarea_model.dart';
import 'package:assetsync/services/custom_sneak_bar.dart';
import 'package:assetsync/utils/constant.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mailer/mailer.dart';
import 'package:mysql1/mysql1.dart';

class DistrictMySqlHelper {
  static Future<DistrictModel?> login(
      BuildContext context, String username, String password) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) async {
      return await conn.query(
          'select * from admin,states,district WHERE admin.id = district.admin_id AND states.id = district.state_id and admin.username = ?',
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
            return DistrictModel(
                id: value.first['admin_id'],
                name: value.first['name'],
                email: value.first['email'],
                phone: value.first['phone'],
                password: value.first['password'],
                username: value.first['username'],
                stateId: value.first['state_id'],
                districtId: value.first['id']);
          }
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());
        return null;
      });
    });
  }

  static Future<DistrictModel?> getUser(int id) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query(
          'select * from admin,states,district WHERE admin.id = district.admin_id AND states.id = district.state_id and admin.id = ?',
          [id]).then((value) {
        if (value.isEmpty) {
          return null;
        } else {
          return DistrictModel(
              id: value.first['admin_id'],
              name: value.first['name'],
              email: value.first['email'],
              phone: value.first['phone'],
              password: value.first['password'],
              username: value.first['username'],
              stateId: value.first['state_id'],
              districtId: value.first['id']);
        }
      }).onError((error, stackTrace) {
        return null;
      });
    });
  }

  static Future<List<AssetsCountModel>> getAssetsCount(
      BuildContext context, int districtId) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query(
          'SELECT type,COUNt(*) as count FROM `asset` WHERE asset.district_id = ? and asset.isApproved = true GROUP by type ORDER BY COUNT(*) DESC;',
          [districtId]).then((value) {
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

  static Future<List<AssetModel>> getAssest(
      BuildContext context, int districtId) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query(
          'SELECT asset.id, asset.state_id, asset.district_id,  asset.name, `type`, `address`, `size`, `capacity`, `present_use`, `yaer_of_est`, `rooms`, `labs`, `maintance`, `floors`, `owner`, `working_space`, `vaccant_space`, `parking`, `lon`, `lat`  ,sub_area.name as subArea FROM `asset` JOIN sub_area ON sub_area.id= asset.sub_area_id WHERE asset.district_id = ? and `isApproved` = true;',
          [districtId]).then((value) {
        if (value.isEmpty) {
          return <AssetModel>[];
        } else {
          List<AssetModel> result = [];

          for (var raw in value) {
            result.add(AssetModel(
                id: raw['id'],
                stateId: raw['state_id'],
                districtId: raw['district_id'],
                subAreaId: 0,
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
                lat: raw['lat'],
                subArea: raw['subArea']));
          }
          return result;
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());

        return <AssetModel>[];
      });
    });
  }

  static Future<List<MaintanceModel>> getAssestRequestes(
      BuildContext context, int districtId) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query(
          'SELECT maintain.id , sub_area.name as subArea , asset.name, `asset_id`, `asset_id`,`requirement`, `budget`, `proposal`, maintain.type, `district_approval`, `state_approval` FROM `maintain` JOIN asset ON asset.id = maintain.asset_id  JOIN sub_area ON sub_area.id = asset.sub_area_id WHERE asset.district_id= ? and district_approval is NULL and asset.isApproved = true',
          [districtId]).then((value) {
        if (value.isEmpty) {
          return <MaintanceModel>[];
        } else {
          List<MaintanceModel> result = [];
          for (var raw in value) {
            result.add(MaintanceModel(
                id: raw['id'],
                assetId: raw['asset_id'],
                name: raw['name'],
                requirement: raw['requirement'],
                budget: raw['budget'],
                proposal: raw['proposal'],
                type: raw['type'],
                districtApproval: raw['district_approval'] == 0 ? false : true,
                stateApproval: raw['state_approval'] == 0 ? false : true,
                subArea: raw['subArea']));
          }
          return result;
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());

        return <MaintanceModel>[];
      });
    });
  }

// This is for the list of the assets that are needed to be verified by the district
  static Future<List<AssetModel>> getAssestforverification(
      BuildContext context, int districtId) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query(
          'SELECT  admin.email, asset.id, asset.state_id, asset.district_id, asset.sub_area_id, asset.name, `type`, `address`, `size`, `capacity`, `present_use`, `yaer_of_est`, `rooms`, `labs`, `maintance`, `floors`, `owner`, `working_space`, `vaccant_space`, `parking`, `lon`, `lat`, `isApproved`, `remark` FROM `asset` JOIN sub_area ON asset.sub_area_id = sub_area.id JOIN admin ON admin.id = sub_area.admin_id WHERE asset.district_id = ? and asset.isApproved is NULL ',
          [districtId]).then((value) {
        if (value.isEmpty) {
          return <AssetModel>[];
        } else {
          List<AssetModel> result = [];

          for (var raw in value) {
            result.add(AssetModel(
                id: raw['id'],
                stateId: raw['state_id'],
                districtId: raw['district_id'],
                subAreaId: 0,
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
                lat: raw['lat'],
                subAreaAdminEmial: raw['email']));
          }
          return result;
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());

        return <AssetModel>[];
      });
    });
  }

  //verify the asset and isApproved will become true
  static Future<void> verifytheasset(
      BuildContext context, int assetId, bool type) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query(
          'update `asset` set `isApproved` = ? where asset.id = ?',
          [type, assetId]).then((value) {
        showSuccessMessage(context, "Asset Rejected succesfully");
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());
      });
    });
  }

//Verify the assed and isApproved will become true
  static Future<void> maintenanceVerification(
      BuildContext context, int assetId, bool type) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query(
          'update `maintain` set `district_approval` = ? where maintain.id = ?',
          [type, assetId]).then((value) {
        if (type) {
          showSuccessMessage(context, "Asset Accepted succesfully");
        } else {
          showErrorMessage(context, "Asset Rejected succesfully");
        }
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());
      });
    });
  }

  static Future<List<SubAreaModel>> getSubArea(
      BuildContext context, int districtId) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query(
          'select * from admin,states ,district, sub_area WHERE admin.id = sub_area.admin_id AND district.id = sub_area.district_id AND states.id = sub_area.state_id AND district.id = ?',
          [districtId]).then((value) {
        if (value.isEmpty) {
          return <SubAreaModel>[];
        } else {
          List<SubAreaModel> result = [];

          for (var raw in value) {
            result.add(SubAreaModel(
                id: raw['admin_id'],
                name: raw['name'],
                email: raw['email'],
                phone: raw['phone'],
                password: raw['password'],
                username: raw['username'],
                stateId: raw['state_id'],
                districtId: districtId,
                subAreaId: raw['id']));
          }
          return result;
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());

        return <SubAreaModel>[];
      });
    });
  }

  static Future<void> addDSubArea(
      BuildContext context, String name, String email, String phone) async {
    GloablAuthCubit block = BlocProvider.of<GloablAuthCubit>(context);
    final districtId =
        BlocProvider.of<GloablAuthCubit>(context).districtModel!.districtId;

    String userName =
        '${name.replaceAll(' ', '').toLowerCase()}@assetsync.tech';
    String password = name.replaceAll(' ', '').toLowerCase();
    // String password = RandomPasswordGenerator().randomPassword(
    //     letters: true, uppercase: true, number: true, passwordLength: 10);
    // ignore: deprecated_member_use

    final message = Message()
      ..from = senderAdress
      ..recipients.add(email)
      ..subject = 'District Login Credentials'
      ..text =
          'Welcome To Assets Sync.\nSub Area Login Credentials. \n\n\nUser Id  : $userName\nPassword : $password';

    try {
      return await send(message, smtpServer).then((value) async {
        return await MySqlConnection.connect(connectionSettings)
            .then((conn) async {
          final hmacSha256 = Hmac(sha256, secretKey); // HMAC-SHA256
          final passwordDigest =
              hmacSha256.convert(utf8.encode(password)).toString();
          return await conn.query(
              'INSERT INTO `admin` (`id`, `name`, `email`, `phone`, `password`, `username`) VALUES (NULL, ? , ? , ? , ?, ? )',
              [
                name,
                email,
                phone,
                passwordDigest,
                userName
              ]).then((result) async {
            return await conn.query(
              ' INSERT INTO `sub_area` (`id`, `state_id`, `district_id`, `name`, `admin_id`) VALUES (NULL, ?, ?, ?, ?)',
              [block.districtModel!.stateId, districtId, name, result.insertId],
            ).then((result) async {
              return;
            }).onError((error, stackTrace) {
              showErrorMessage(context, error.toString());
            });
          }).onError((error, stackTrace) {
            showErrorMessage(context, error.toString());
          });
        });
      });
    } on MailerException catch (e) {
      showErrorMessage(context, e.toString());
    }
  }
}
