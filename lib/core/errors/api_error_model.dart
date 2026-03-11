class ApiErrorModel {
  ApiErrorModel({
    required this.timestamp,
    required this.status,
    required this.error,
    required this.message,
    required this.path,
    this.supportId,
    this.technicalDetails,
  });

  final String? timestamp;
  final int status;
  final String error;
  final String message;
  final String path;
  final String? supportId;
  final String? technicalDetails;

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      timestamp: json['timestamp'] as String?,
      status: json['status'] as int,
      error: json['error'] as String? ?? 'Erro',
      message: json['message'] as String? ?? 'Ocorreu um erro.',
      path: json['path'] as String? ?? '',
      supportId: json['supportId'] as String?,
      technicalDetails: json['technicalDetails'] as String?,
    );
  }
}