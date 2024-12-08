import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:template/features/post/page/widgets/list_posts_scraan.dart';
import 'package:template/features/post/provider/pagination_posts_provider.dart';

class PostScraan extends ConsumerStatefulWidget {
  const PostScraan({super.key});

  @override
  ConsumerState<PostScraan> createState() => _PostScraanState();
}

class _PostScraanState extends ConsumerState<PostScraan> {
  final ScrollController _controller = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
    super.dispose();
  }

  void _onRefresh() async {
    ref
        .watch(paginationPostsController)
        .copyWith(isError: false, isLoading: false, hasMore: true, posts: []);
    ref.read(paginationPostsController.notifier).onRefresh(_refreshController);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(paginationPostsController);

    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              List_Posts_Scraan(controller: _controller, state: state),
              if (state.isError)
                Center(
                  child: Text(state.errorModel?.message ?? 'An error occurred'),
                ),
              if (!state.hasMore) Text('this all data')
            ],
          ),
        ),
      ),
    );
  }
}
