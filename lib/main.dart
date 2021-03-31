import 'package:block_cubit/posts_bloc.dart';
import 'package:block_cubit/posts_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test BLoC with Provider',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<PostsBloc>(
            create: (context) => PostsBloc()..add(LoadPostsEvent()),
          ),
        ],
        child: PostsView(),
      ),
    );
  }
}
