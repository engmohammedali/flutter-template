import 'package:flutter/material.dart';
import 'package:template/features/post/data/model/post_model.dart';
import 'package:template/features/post/page/details_post.dart';

class List_Posts_Scraan extends StatelessWidget {
  const List_Posts_Scraan({
    super.key,
    required ScrollController controller,
    required this.posts,
  }) : _controller = controller;

  final ScrollController _controller;
  final List<PostModel> posts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _controller,
        itemCount: posts.length,
        itemBuilder: (context, int index) {
          print(posts.length);
          if (index < posts.length) {
            return Padding(
              padding:
                  EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPost(
                        title: posts[index].title,
                        id: posts[index].id,
                        userId: posts[index].userId,
                        body: posts[index].body,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(posts[index].title),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
