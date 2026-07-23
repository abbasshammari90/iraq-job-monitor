import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();

  NetworkService._internal() {
    _connectivity.onConnectivityChanged.listen((result) {
      _connectionStatusController.add(result.contains(ConnectivityResult.none) ? false : true);
    });
  }

  factory NetworkService() {
    return _instance;
  }

  Stream<bool> get connectionStatus => _connectionStatusController.stream;

  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  void dispose() {
    _connectionStatusController.close();
  }
}
