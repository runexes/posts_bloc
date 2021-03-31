import 'package:block_cubit/post.dart';
import 'package:block_cubit/posts_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PostsEvent {}

class LoadPostsEvent extends PostsEvent {}

class PullToRefreshEvent extends PostsEvent {}

abstract class PostsState {}

class LoadingPostsState extends PostsState {}

class LoadedPostsState extends PostsState {
  List<Post> posts;
  LoadedPostsState({required this.posts});
}

class FailedToLoadPostsState extends PostsState {
  Error error;
  FailedToLoadPostsState({required this.error});
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final _dataService = PostsService();

  PostsBloc() : super(LoadingPostsState());

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if (event is LoadPostsEvent || event is PullToRefreshEvent) {
      yield LoadingPostsState();

      try {
        final posts = await _dataService.getPosts();
        yield LoadedPostsState(posts: posts);
      } catch (e) {
        FailedToLoadPostsState(error: e as Error);
      }
    }
  }
}
