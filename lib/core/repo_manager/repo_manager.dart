import 'package:dartz/dartz.dart';
import 'package:shorts/core/error_manager/failure.dart';


abstract class RepoManager {
  const RepoManager();
  Future<Either<Failure, T>> call<T>({
    required Future<T> Function() action,
  });
}
