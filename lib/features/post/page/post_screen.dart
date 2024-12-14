import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/post/page/widgets/custom_search_post.dart';
import 'package:template/features/post/page/widgets/list_posts_scraan.dart';
import 'package:template/features/post/provider/pagination_posts_provider.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScraanState();
}

class _PostScraanState extends ConsumerState<PostScreen> {
  final ScrollController _controller = ScrollController();

  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        ref.read(paginationPostsController.notifier).fetchPosts();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(paginationPostsController);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: PostSearchDelegate(_controller),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          List_Posts_Scraan(controller: _controller, posts: state.posts),
          if (state.isError)
            Center(
              child:
                  Text(state.errorModel?.statusMessage ?? 'An error occurred'),
            ),
          if (!state.hasMore) Text('this all data')
        ],
      ),
    );
  }
}
