import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';

import '../../../../core/network/Hive_manager/hive_boxes_names.dart';
import '../../../../core/network/Hive_manager/hive_helper.dart';

abstract class CommentsLocalDataSource {
  const CommentsLocalDataSource._();

  Future<List<CommentEntity>> getComments({required String videoId});
  Future<void> saveComments(List<CommentEntity> comments);
  Future<void> removeComment(String commentId);
  Future<void> clearComments(String videoId);
}

class CommentsLocalDataSourceImpl implements CommentsLocalDataSource {
  final LocalStorageManager localStorageManager;

  const CommentsLocalDataSourceImpl({required this.localStorageManager});

  @override
  Future<List<CommentEntity>> getComments({
    required String videoId,
  }) async {
    final commentItems = await localStorageManager.loadData<CommentEntity>(
      HiveBoxesNames.kCommentsBox,
    );
    return commentItems.cast<CommentEntity>().toList();
  }

  @override
  Future<void> saveComments(List<CommentEntity> comments) async {
    await localStorageManager.saveData<CommentEntity>(
      comments,
      HiveBoxesNames.kCommentsBox,
    );
  }

  @override
  Future<void> removeComment(String commentId) async {
    final commentItems = await getComments(
      videoId: commentId,
    );
    final updatedCommentItems =
        commentItems.where((item) => item.id != commentId).toList();
    await saveComments(updatedCommentItems);
  }

  @override
  Future<void> clearComments(String videoId) async {
    await localStorageManager.clearData<CommentEntity>(
      HiveBoxesNames.kCommentsBox,
    );
  }
}
