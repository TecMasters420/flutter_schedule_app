class ApiResponseModel {
  final String? status;
  final String? type;
  final List<String>? messages;
  final int code;
  final String body;
  final dynamic data;
  ApiResponseModel({
    required this.code,
    required this.body,
    this.status,
    this.messages,
    this.data,
    this.type,
  });

  factory ApiResponseModel.fromMap(Map<String, dynamic> map) {
    return ApiResponseModel(
      status: map['status'],
      code: map['code'],
      messages: List.from(map['messages']).map((e) => e.toString()).toList(),
      type: map['type'],
      body: map['body'],
    );
  }
}
