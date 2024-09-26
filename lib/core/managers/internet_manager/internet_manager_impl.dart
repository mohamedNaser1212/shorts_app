import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'internet_manager.dart';
import 'internet_status.dart';

class InternetManagerImpl implements InternetManager {
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker();

  @override
  Future<bool> checkConnection() async {
    return await _connectionChecker.hasConnection;
  }

  @override
  Future<String?> getNetworkType() async {
    final status = await _connectionChecker.connectionStatus;
    switch (status) {
      case InternetConnectionStatus.connected:
        return InternetStatus.connected;
      case InternetConnectionStatus.disconnected:
        return InternetStatus.disconnected;
      default:
        return null;
    }
  }
}
