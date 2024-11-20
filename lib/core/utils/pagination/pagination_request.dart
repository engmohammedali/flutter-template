class PaginationRequest {
  final int page;

  PaginationRequest({
    required this.page,
  });

  factory PaginationRequest.fromJson(Map<String, dynamic> json) =>
      PaginationRequest(
        page: json['page'],
      );

  Map<String, dynamic> toJson() => {
        'page': page,
      };
}
