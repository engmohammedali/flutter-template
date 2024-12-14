import 'package:dio/dio.dart';
import 'package:template/features/post/data/model/error_model.dart';
import 'package:template/features/post/data/model/post_model.dart';
import 'package:template/features/post/error/exsapation/exception.dart';

class Post {
  final baseUrl = 'https://dummyjson.com';
  Future<List<PostModel>> getPostsFromApi(
      [int maxlimt = 10, int skip = 0]) async {
    final Response response = await Dio(BaseOptions(baseUrl: baseUrl))
        .get('/posts?limit=$maxlimt&skip=$skip');
    return _verificationAndReturnPost(response);
  }

  Future<List<PostModel>> searchPostFormApi(String query) async {
    final Response response =
        await Dio(BaseOptions(baseUrl: baseUrl)).get('/posts/search?q=$query');
    return _verificationAndReturnPost(response);
  }

  List<PostModel> _verificationAndReturnPost(Response<dynamic> response) {
    if (response.statusCode == 200) {
      return List<PostModel>.from(
        (response.data['posts'] as List).map(
          (e) => PostModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(errorModel: ErrorModel.fromJson(response.data));
    }
  }
}
