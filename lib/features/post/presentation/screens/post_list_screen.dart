import 'package:cleanarch/features/post/presentation/bloc/post_bloc.dart';
import 'package:cleanarch/features/post/presentation/bloc/post_event.dart';
import 'package:cleanarch/features/post/presentation/bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          
          if(state is PostLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is PostLoadedState) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            );
          }
          else if (state is PostErrorState) {
            return Center(child: Text(state.message));
          }

          return TextButton(
            onPressed: () {
              context.read<PostBloc>().add(PostFetchEvent());
            },
            child: const Text('Load Posts'),
          );

        },
      ),
    );
  }
}