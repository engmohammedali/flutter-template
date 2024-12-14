class ErrorModel {
  final int statusCode;
  final String statusMessage;
  ErrorModel({
    required this.statusCode,
    required this.statusMessage,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
        statusCode: json['statusCode'], statusMessage: json['statusMessage']);
  }
}
