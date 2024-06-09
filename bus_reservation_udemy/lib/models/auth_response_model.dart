class AuthResponseModel {
  int statusCode;
  String message;
  String accessToken;
  int logInTime;
  int expirationDuration;

  AuthResponseModel({
    required this.statusCode,
    required this.message,
    required this.accessToken,
    required this.logInTime,
    required this.expirationDuration,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json)=> AuthResponseModel(
      statusCode: json['statusCode'],
      message: json['message'],
      accessToken: json['accessToken'],
      logInTime: json ['logInTime'],
      expirationDuration: json['expirationDuration'],
  );
}
