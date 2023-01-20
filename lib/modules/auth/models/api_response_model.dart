class ApiResponseModel {
  final String? status;
  final int code;
  final String? message;
  final String body;
  ApiResponseModel({
    required this.code,
    required this.body,
    this.status,
    this.message,
  });

  factory ApiResponseModel.fromMap(Map<String, dynamic> map) {
    return ApiResponseModel(
      status: map['status'],
      code: map['code'],
      message: map['message'],
      body: map['body'],
    );
  }
}
