class AuthModel {
  AuthModel({
    required this.accessToken,
    required this.tokenType,
    this.expiresIn,
  });

  final String accessToken;
  final String tokenType;
  final int? expiresIn;

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken'] as String,
      tokenType: json['tokenType'] as String? ?? 'Bearer',
      expiresIn: json['expiresIn'] as int?,
    );
  }
}