import 'package:assetsync/database/admin_mysql_helper.dart';
import 'package:assetsync/database/district_mysql_helper.dart';
import 'package:assetsync/database/state_mysql_helper.dart';
import 'package:assetsync/database/subarea_mysql_helper.dart';
import 'package:assetsync/model/admin_model.dart';
import 'package:assetsync/model/district_model.dart';
import 'package:assetsync/model/state_model.dart';
import 'package:assetsync/model/subarea_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { init, loading, loggedIn, loggedOut, error }

class GloablAuthCubit extends Cubit<AuthState> {
  late int userType;
  late int userId;
  AdminModel? adminModel;
  StateModel? stateModel;
  DistrictModel? districtModel;
  SubAreaModel? subAreaModel;
  GloablAuthCubit() : super(AuthState.loading) {
    authCheck();
    emit(AuthState.loading);
  }

  void authCheck() async {
    SharedPreferences.getInstance().then((sharedPreferences) async {
      if (sharedPreferences.getBool('loggedIn') ?? false) {
        userType = sharedPreferences.getInt('userType') ?? -1;
        userId = sharedPreferences.getInt('userId') ?? -1;
        switch (userType) {
          case -1:
            emit(AuthState.loggedOut);
            break;
          case 0:
            {
              await AdminMySQLHelper.getUser(userId).then((value) {
                if (value != null) {
                  emit(AuthState.loggedIn);
                  adminModel = value;
                } else {
                  emit(AuthState.loggedOut);
                }
              });
            }
            break;
          case 1:
            {
              await StateMySQLHelper.getUser(userId).then((value) {
                if (value != null) {
                  emit(AuthState.loggedIn);
                  stateModel = value;
                } else {
                  emit(AuthState.loggedOut);
                }
              });
            }
            break;
          case 2:
            {
              await DistrictMySqlHelper.getUser(userId).then((value) {
                if (value != null) {
                  emit(AuthState.loggedIn);
                  districtModel = value;
                } else {
                  emit(AuthState.loggedOut);
                }
              });
            }
            break;
          case 3:
            {
              await SubAreaHelper.getUser(userId).then((value) {
                if (value != null) {
                  emit(AuthState.loggedIn);
                  subAreaModel = value;
                } else {
                  emit(AuthState.loggedOut);
                }
              });
            }
            break;
        }
      } else {
        emit(AuthState.loggedOut);
      }
    });
  }

  void loginSuperAdmin(AdminModel adminModel) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setBool('loggedIn', true);
      sharedPreferences.setInt('userType', 0);
      sharedPreferences.setInt('userId', 1);
      this.adminModel = adminModel;
      userType = 0;
      userId = 1;
      emit(AuthState.loggedIn);
      return;
    });
  }

  void loginStateAdmin(StateModel stateModel) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setBool('loggedIn', true);
      sharedPreferences.setInt('userType', 1);
      sharedPreferences.setInt('userId', stateModel.id);
      this.stateModel = stateModel;
      userType = 1;
      userId = stateModel.id;
      emit(AuthState.loggedIn);
      return;
    });
  }

  void loginDistrictAdmin(DistrictModel districtModel) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setBool('loggedIn', true);
      sharedPreferences.setInt('userType', 2);
      sharedPreferences.setInt('userId', districtModel.id);
      userType = 2;
      userId = districtModel.id;
      this.districtModel = districtModel;
      emit(AuthState.loggedIn);
      return;
    });
  }

  void loginSubAreaAdmin(SubAreaModel subAreaModel) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setBool('loggedIn', true);
      sharedPreferences.setInt('userType', 3);
      sharedPreferences.setInt('userId', subAreaModel.id);
      userType = 3;
      userId = subAreaModel.id;
      this.subAreaModel = subAreaModel;
      emit(AuthState.loggedIn);
      return;
    });
  }

  void logout() async {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setBool('loggedIn', false);
      sharedPreferences.setInt('userType', -1);
      sharedPreferences.setInt('userId', -1);
      emit(AuthState.loggedOut);
      return;
    });
  }
}
