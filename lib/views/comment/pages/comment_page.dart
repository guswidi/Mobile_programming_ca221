import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/views/moment/bloc/comment_bloc.dart';
import 'package:myapp/repositories/databases/comment_repository.dart'; // Pastikan import repository

class CommentPage extends StatelessWidget {
  final String momentId;

  const CommentPage({super.key, required this.momentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentBloc(
        RepositoryProvider.of<CommentRepository>(context), // Pastikan CommentRepository tersedia di context
      )..add(LoadCommentsEvent(momentId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
        ),
        body: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            if (state is CommentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CommentError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is CommentLoaded) {
              return ListView.builder(
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  final comment = state.comments[index];
                  return ListTile(
                    title: Text(comment.creator),
                    subtitle: Text(comment.content),
                  );
                },
              );
            }
            return const Center(child: Text('No comments yet.'));
          },
        ),
      ),
    );
  }
}
