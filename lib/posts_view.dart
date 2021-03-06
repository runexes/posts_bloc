import 'package:block_cubit/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsView extends StatelessWidget {
  PostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is LoadingPostsState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedPostsState) {
          return RefreshIndicator(
            onRefresh: () async =>
                BlocProvider.of<PostsBloc>(context).add(PullToRefreshEvent()),
            child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (_, index) {
                  return Card(
                    child: ListTile(
                      title: Text(state.posts[index].title),
                    ),
                  );
                }),
          );
        } else if (state is FailedToLoadPostsState) {
          return Center(
            child: Text('Error occured: ${state.error}'),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
