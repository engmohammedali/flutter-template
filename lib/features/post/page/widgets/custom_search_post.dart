import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/post/data/model/post_model.dart';
import 'package:template/features/post/page/widgets/list_posts_scraan.dart';
import 'package:template/features/post/provider/pagination_posts_provider.dart';

class PostSearchDelegate extends SearchDelegate {
  Timer? _debounceTimer;
  final ScrollController _controller;
  PostSearchDelegate(this._controller);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('Write to Search'),
      );
    }
    Timer? debounceTimer;
    if (debounceTimer?.isActive ?? false) {
      debounceTimer?.cancel();
    }
    debounceTimer = Timer(Duration(milliseconds: 250), () {});

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer(
          builder: (context, ref, child) => FutureBuilder(
            future:
                ref.read(paginationPostsController.notifier).searchPost(query),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapShot.hasError) {
                return Center(
                    child:
                        Text('an error occurred ${snapShot.error.toString()}'));
              }
              print(query);
              final List<PostModel> posts = snapShot.data ?? [];
              return List_Posts_Scraan(controller: _controller, posts: posts);
            },
          ),
        ),
      ],
    );
  }
}
