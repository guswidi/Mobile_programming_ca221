import 'package:myapp/models/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> getComments(String momentId);
  Future<void> addComment(String momentId, Comment comment);
  Future<void> updateComment(String momentId, Comment comment);
  Future<void> deleteComment(String momentId, String commentId);
}

class CommentRepositoryImpl implements CommentRepository {
  final List<Comment> _comments = [];

  @override
  Future<List<Comment>> getComments(String momentId) async {
    return _comments.where((comment) => comment.momentId == momentId).toList();
  }

  @override
  Future<void> addComment(String momentId, Comment comment) async {
    _comments.add(comment);
  }

  @override
  Future<void> updateComment(String momentId, Comment comment) async {
    final index = _comments.indexWhere((c) => c.id == comment.id);
    if (index != -1) {
      _comments[index] = comment;
    }
  }

  @override
  Future<void> deleteComment(String momentId, String commentId) async {
    _comments.removeWhere((comment) => comment.id == commentId);
  }
}
