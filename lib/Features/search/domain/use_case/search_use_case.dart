import 'package:dartz/dartz.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../repo/search_repo.dart';

class SearchUseCase {
  final SearchRepo searchRepo;

  SearchUseCase({
    required this.searchRepo,
  });

  Future<Either<Failure, List<UserEntity>>> call({
    required String search,
  }) async {
    return await searchRepo.search(query: search);
  }
}
