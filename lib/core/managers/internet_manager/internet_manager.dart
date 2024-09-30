abstract class InternetManager {
  const InternetManager._();
  Future<bool> checkConnection();
  Future<String?> getNetworkType();
}
