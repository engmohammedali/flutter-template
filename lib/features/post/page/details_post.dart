import 'package:flutter/material.dart';

class DetailsPost extends StatelessWidget {
  final String body;
  final String title;
  final int userId;
  final int id;
  const DetailsPost(
      {super.key,
      required this.body,
      required this.title,
      required this.id,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
            child: ListTile(
          leading: Text(userId.toString()),
          trailing: Text(id.toString()),
          title: Text(title),
          subtitle: Text(
            body,
            style: TextStyle(fontSize: 10),
          ),
        )),
      ),
    );
  }
}
