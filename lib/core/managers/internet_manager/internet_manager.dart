abstract class InternetManager {
  const InternetManager();
  Future<bool> checkConnection();
  Future<String?> getNetworkType();
}
