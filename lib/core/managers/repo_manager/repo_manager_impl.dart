import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../error_manager/failure.dart';
import '../error_manager/firebase_failure.dart';
import '../error_manager/internet_failure.dart';
import '../error_manager/server_failure.dart';
import '../internet_manager/internet_manager.dart';
import 'repo_manager.dart';

class RepoManagerImpl extends RepoManager {
  final InternetManager internetManager;

  const RepoManagerImpl({
    required this.internetManager,
  });

  @override
  Future<Either<Failure, T>> call<T>({
    required Future<T> Function() action,
  }) async {
    try {
      final isConnected = await internetManager.checkConnection();
      if (!isConnected) {
        return left(
          InternetFailure.fromConnectionStatus(
            InternetConnectionStatus.disconnected,
          ),
        );
      }
      final result = await action();
      return right(result);
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        return left(const ServerFailure(
            message:
                'You have made too many requests. PleaSe try again later.'));
      }
      return left(ServerFailure.fromDioError(e));
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.fromFirebaseError(e));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
