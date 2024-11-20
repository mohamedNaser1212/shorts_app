import 'package:dartz/dartz.dart';
import 'package:shorts/Features/search/data/data_sources/search_remote_data_source.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';
import 'package:shorts/core/managers/repo_manager/repo_manager.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../domain/repo/search_repo.dart';

class SearchRepoImpl extends SearchRepo {
  final RepoManager repoManager;
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchRepoImpl({
    required this.repoManager,
    required this.searchRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> search({
    required String query,
    required int page,
  }) {
    return repoManager.call(
      action: () async {
        final searchResults =
            await searchRemoteDataSource.search(query: query, page: page);

        return searchResults;
      },
    );
  }
}
