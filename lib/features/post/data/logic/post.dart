import 'package:dio/dio.dart';
import 'package:template/features/post/data/model/error_model.dart';
import 'package:template/features/post/data/model/post_model.dart';
import 'package:template/features/post/error/exsapation/exception.dart';

class Post {
  static String baseUrl = 'https://jsonplaceholder.typicode.com';
  static Future<List<PostModel>> getPosts(
      {required int page, int maxlimt = 10}) async {
    final response = await Dio(BaseOptions(baseUrl: baseUrl))
        .get('/posts?_page=$page&_limit=$maxlimt');

    if (response.statusCode == 200) {
      return List<PostModel>.from(
        (response.data as List).map(
          (e) => PostModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(errorModel: ErrorModel(message: response.data));
    }
  }
}
