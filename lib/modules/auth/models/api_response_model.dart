class ApiResponseModel {
  final String? status;
  final int code;
  final String? message;
  final String body;
  final dynamic data;
  ApiResponseModel({
    required this.code,
    required this.body,
    this.status,
    this.message,
    this.data,
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
