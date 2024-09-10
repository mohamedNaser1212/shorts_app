abstract class FirebaseHelper {
  const FirebaseHelper();

  Future<List<Map<String, dynamic>>> get({
    required String collectionPath,
  });

  Future<void> post({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<void> update({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  });

  Future<void> delete({
    required String collectionPath,
    required String documentId,
  });

  Future<String> uploadVideoToStorage({
    required String videoPath,
    required String videoId,
  });
}
