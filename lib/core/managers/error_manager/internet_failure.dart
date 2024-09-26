import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'failure.dart';

class InternetFailure extends Failure {
  const InternetFailure({required super.message});

  factory InternetFailure.fromConnectionStatus(
      InternetConnectionStatus status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        return const InternetFailure(message: 'Connected but facing issues.');
      case InternetConnectionStatus.disconnected:
        return const InternetFailure(message: 'No Internet Connection.');
      default:
        return const InternetFailure(message: 'Unknown internet status.');
    }
  }
}

// class InternetFailureManager {
//   final InternetConnectionChecker _connectionChecker =
//       InternetConnectionChecker();
//
//   Future<InternetManager?> checkInternetConnection() async {
//     final isConnected = await _connectionChecker.hasConnection;
//     if (!isConnected) {
//       return const InternetFailure(message: 'No Internet Connection.');
//     }
//     return null;
//   }
//
//   Future<InternetManager?> getInternetStatus() async {
//     final status = await _connectionChecker.connectionStatus;
//     if (status == InternetConnectionStatus.disconnected) {
//       return const InternetFailure(message: 'No Internet Connection.');
//     } else if (status == InternetConnectionStatus.connected) {
//       return null; // No failure if connected.
//     } else {
//       return const InternetFailure(message: 'Unknown internet status.');
//     }
//   }
// }
