import 'dart:convert';

import 'package:assetsync/model/admin_model.dart';
import 'package:assetsync/model/assests_count_model.dart';
import 'package:assetsync/model/asset_model.dart';
import 'package:assetsync/model/state_model.dart';
import 'package:assetsync/services/custom_sneak_bar.dart';
import 'package:assetsync/utils/constant.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mysql1/mysql1.dart';

class AdminMySQLHelper {
  static Future<AdminModel?> login(
      BuildContext context, String username, String password) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) async {
      return await conn
          .query('select * from admin where id = ?', [1]).then((value) {
        if (value.isEmpty) {
          showErrorMessage(context, 'No user Exists');
          return null;
        } else {
          final hmacSha256 = Hmac(sha256, secretKey); // HMAC-SHA256
          final passwordDigest =
              hmacSha256.convert(utf8.encode(password)).toString();
          if (value.first['username'] != username) {
            showErrorMessage(context, 'No user Exists');
            return null;
          } else if (value.first['password'] != passwordDigest) {
            showErrorMessage(context, 'Wrong Password');
            return null;
          } else {
            showSuccessMessage(context, 'Login SucessFully');
            return AdminModel(
                id: value.first['id'],
                name: value.first['name'],
                email: value.first['email'],
                phone: value.first['phone'].toString(),
                password: value.first['password'],
                username: value.first['username']);
          }
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());
        return null;
      });
    });
  }

  static Future<AdminModel?> getUser(int id) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn.query('select * from admin where id = ?', [id]).then((value) {
        if (value.isEmpty) {
          return null;
        } else {
          return AdminModel(
              id: value.first['id'],
              name: value.first['name'],
              email: value.first['email'],
              phone: value.first['phone'],
              password: value.first['password'],
              username: value.first['username']);
        }
      }).onError((error, stackTrace) {
        return null;
      });
    });
  }

  static Future<List<AssetsCountModel>> getAssetsCount(
      BuildContext context) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn
          .query(
              'SELECT type,COUNt(*) as count  FROM `asset` where asset.isApproved = true GROUP by type ORDER BY COUNT(*) DESC ;')
          .then((value) {
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
      BuildContext context, String query) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn
          .query(
              'SELECT asset.id, asset.state_id, asset.district_id,  asset.name, `type`, `address`, `size`, `capacity`, `present_use`, `yaer_of_est`, `rooms`, `labs`, `maintance`, `floors`, `owner`, `working_space`, `vaccant_space`, `parking`, `lon`, `lat`  ,sub_area.name as subArea,district.name as district, states.name as state  FROM `asset` JOIN states ON states.id = asset.state_id JOIN district On district.id = asset.district_id JOIN sub_area ON sub_area.id= asset.sub_area_id $query and `isApproved` = true')
          .then((value) {
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
                subArea: raw['subArea'],
                district: raw['district'],
                state: raw['state']));
          }
          return result;
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());

        return <AssetModel>[];
      });
    });
  }

  static Future<List<StateModel>> getStates(BuildContext context) async {
    return await MySqlConnection.connect(connectionSettings).then((conn) {
      return conn
          .query('select * from admin,states WHERE admin.id = states.admin_id;')
          .then((value) {
        if (value.isEmpty) {
          return <StateModel>[];
        } else {
          List<StateModel> result = [];

          for (var raw in value) {
            result.add(StateModel(
                id: raw['admin_id'],
                name: raw['name'],
                email: raw['email'],
                phone: raw['phone'],
                password: raw['password'],
                username: raw['username'],
                stateId: raw['id']));
          }
          return result;
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());

        return <StateModel>[];
      });
    });
  }

  static Future<void> addState(
      BuildContext context, String name, String email, String phone) async {
    String userName =
        '${name.replaceAll(' ', '').toLowerCase()}@assetsync.tech';
    String password = name.replaceAll(' ', '').toLowerCase();
    // String password = RandomPasswordGenerator().randomPassword(
    //     letters: true, uppercase: true, number: true, passwordLength: 10);

    final message = Message()
      ..from = senderAdress
      ..recipients.add(email)
      ..subject = 'State Login Credentials'
      ..text =
          'Welcome To Assets Sync.\nState Login Credentials. \n\n\nUser Id  : $userName\nPassword : $password';

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
              'INSERT INTO `states` (`id`, `name`, `admin_id`) VALUES (NULL, ? , ?);',
              [name, result.insertId],
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
