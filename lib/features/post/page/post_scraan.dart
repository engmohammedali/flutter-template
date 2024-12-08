import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/post/data/model/pafination.dart';
import 'package:template/features/post/provider/pagination_posts_provider.dart';

class PostScraan extends ConsumerStatefulWidget {
  const PostScraan({super.key});

  @override
  ConsumerState<PostScraan> createState() => _PostScraanState();
}

class _PostScraanState extends ConsumerState<PostScraan> {
  final ScrollController _controller = ScrollController();

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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(paginationPostsController);

    return Scaffold(
      body: SizedBox(
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
          ],
        ),
      ),
    );
  }
}

class List_Posts_Scraan extends StatelessWidget {
  const List_Posts_Scraan({
    super.key,
    required ScrollController controller,
    required this.state,
  }) : _controller = controller;

  final ScrollController _controller;
  final Pagination state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _controller,
        itemCount: state.posts.length + 1,
        itemBuilder: (context, int index) {
          if (index < state.posts.length) {
            return Padding(
              padding:
                  EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
              child: Card(
                child: ListTile(
                  title: Text(state.posts[index].id.toString()),
                ),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ); 
          }
        },
      ),
    );
  }
}
