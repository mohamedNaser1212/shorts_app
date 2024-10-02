import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import '../../../../core/network/Hive_manager/hive_helper.dart';
import '../../../../core/network/Hive_manager/hive_boxes_names.dart';

abstract class CommentsLocalDataSource {
  const CommentsLocalDataSource._();

  Future<List<CommentEntity>> getComments();
  Future<void> saveComments(List<CommentEntity> comments);
  Future<void> removeComment(String commentId);
  Future<void> clearComments(String videoId);
}

class CommentsLocalDataSourceImpl implements CommentsLocalDataSource {
  final LocalStorageManager hiveHelper;

  const CommentsLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<List<CommentEntity>> getComments() async {
    
      final commentItems = await hiveHelper.loadData<CommentEntity>(
        HiveBoxesNames.kCommentsBox,
      );
      return commentItems.cast<CommentEntity>().toList();
   
  }

  @override
  Future<void> saveComments(List<CommentEntity> comments) async {
   
      await hiveHelper.saveData<CommentEntity>(
        comments,
        HiveBoxesNames.kCommentsBox,
      );
      

  }

  @override
  Future<void> removeComment(String commentId) async {
    final commentItems = await getComments();
    final updatedCommentItems =
        commentItems.where((item) => item.id != commentId).toList();
    await saveComments(updatedCommentItems);
  }

  @override
  Future<void> clearComments(String videoId) async {
    await hiveHelper.clearData<CommentEntity>(
      HiveBoxesNames.kCommentsBox,
    );
  }
}
