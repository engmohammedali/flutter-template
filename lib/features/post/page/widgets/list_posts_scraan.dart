import 'package:flutter/material.dart';
import 'package:template/features/post/data/model/pagination.dart';
import 'package:template/features/post/page/details_post.dart';

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
          print(state.posts.length);
          if (index < state.posts.length) {
            return Padding(
              padding:
                  EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPost(
                        title: state.posts[index].title,
                        id: state.posts[index].id,
                        userId: state.posts[index].userId,
                        body: state.posts[index].body,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(state.posts[index].title),
                  ),
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
