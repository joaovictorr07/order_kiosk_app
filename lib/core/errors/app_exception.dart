class AppException implements Exception {
  AppException({
    required this.statusCode,
    required this.title,
    required this.message,
    this.path,
    this.supportId,
    this.technicalDetails,
    this.raw,
  });

  final int? statusCode;
  final String title;
  final String message;
  final String? path;
  final String? supportId;
  final String? technicalDetails;
  final Object? raw;

  bool get isClientError =>
      statusCode != null && statusCode! >= 400 && statusCode! <= 499;

  bool get isServerError => statusCode != null && statusCode! >= 500;

  @override
  String toString() {
    return 'AppException(statusCode: $statusCode, title: $title, message: $message)';
  }
}