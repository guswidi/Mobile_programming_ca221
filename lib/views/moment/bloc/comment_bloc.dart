import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/repositories/databases/comment_repository.dart';
import 'package:myapp/models/comment.dart';

// **Event**
abstract class CommentEvent {}

class LoadCommentsEvent extends CommentEvent {
  final String momentId;

  LoadCommentsEvent(this.momentId);
}

class AddCommentEvent extends CommentEvent {
  final String momentId;
  final Comment comment;

  AddCommentEvent(this.momentId, this.comment);
}

class UpdateCommentEvent extends CommentEvent {
  final String momentId;
  final Comment comment;

  UpdateCommentEvent(this.momentId, this.comment);
}

class DeleteCommentEvent extends CommentEvent {
  final String momentId;
  final String commentId;

  DeleteCommentEvent(this.momentId, this.commentId);
}

// **State**
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<Comment> comments;

  CommentLoaded(this.comments);
}

class CommentError extends CommentState {
  final String message;

  CommentError(this.message);
}

// **Bloc**
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;

  CommentBloc(this.commentRepository) : super(CommentInitial());

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is LoadCommentsEvent) {
      yield CommentLoading();
      try {
        // Mendapatkan daftar komentar berdasarkan momentId
        final comments = await commentRepository.getComments(event.momentId);
        if (comments.isEmpty) {
          yield CommentError("No comments available for this moment.");
        } else {
          yield CommentLoaded(comments); // Menyimpan hasil komentar dalam state
        }
      } catch (e) {
        yield CommentError("Failed to load comments: ${e.toString()}");
      }
    } else if (event is AddCommentEvent) {
      try {
        await commentRepository.addComment(event.momentId, event.comment);
        // Setelah menambah komentar, lakukan pemanggilan ulang untuk mendapatkan komentar terbaru
        final comments = await commentRepository.getComments(event.momentId);
        yield CommentLoaded(comments);
      } catch (e) {
        yield CommentError("Failed to add comment: ${e.toString()}");
      }
    } else if (event is UpdateCommentEvent) {
      try {
        await commentRepository.updateComment(event.momentId, event.comment);
        // Setelah update, dapatkan komentar terbaru
        final comments = await commentRepository.getComments(event.momentId);
        yield CommentLoaded(comments);
      } catch (e) {
        yield CommentError("Failed to update comment: ${e.toString()}");
      }
    } else if (event is DeleteCommentEvent) {
      try {
        await commentRepository.deleteComment(event.momentId, event.commentId);
        // Setelah menghapus komentar, ambil komentar terbaru
        final comments = await commentRepository.getComments(event.momentId);
        yield CommentLoaded(comments);
      } catch (e) {
        yield CommentError("Failed to delete comment: ${e.toString()}");
      }
    }
  }
}
