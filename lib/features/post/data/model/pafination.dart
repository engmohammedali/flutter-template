import 'package:template/features/post/data/model/error_model.dart';
import 'package:template/features/post/data/model/post_model.dart';

class Pagination {
  final bool isLoading;
  final bool hasMore;
  final bool isError;
  final List<PostModel> posts;
  final ErrorModel? errorModel;

  Pagination({
    required this.hasMore,
    required this.isLoading,
    required this.isError,
    required this.posts,
    this.errorModel,
  });

  Pagination copyWith({
    bool? hasMore,
    bool? isLoading,
    List<PostModel>? posts,
    bool? isError,
    ErrorModel? errorModel,
  }) {
    return Pagination(
      posts: posts ?? this.posts,
      hasMore: hasMore ?? this.hasMore,
      errorModel: errorModel ?? this.errorModel,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}

