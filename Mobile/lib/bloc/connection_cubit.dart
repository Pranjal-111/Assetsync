import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

enum ConnectionStates { checking, notConnected, error, connected }

class ConnectionCubit extends Cubit<ConnectionStates> {
  ConnectionCubit() : super(ConnectionStates.checking) {
    initConnectivity();
    emit(ConnectionStates.checking);
  }

  Future<void> initConnectivity() async {
    try {
      Connectivity().onConnectivityChanged.listen((event) {
        if (event == ConnectivityResult.none) {
          emit(ConnectionStates.notConnected);
        } else {
          emit(ConnectionStates.connected);
        }
      });

      Connectivity().checkConnectivity().then((value) {
        if (value == ConnectivityResult.none) {
          emit(ConnectionStates.notConnected);
        } else {
          emit(ConnectionStates.connected);
        }
      });
    } on Exception catch (e) {
      emit(ConnectionStates.error);
      developer.log('Couldn\'t check connectivity status', error: e);
    }
  }
}
