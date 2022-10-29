// To parse this JSON data, do
//
//     final socureErrorResult = socureErrorResultFromJson(jsonString);

import 'dart:convert';

SocureErrorResult socureErrorResultFromJson(String str) =>
    SocureErrorResult.fromJson(json.decode(str));

String socureErrorResultToJson(SocureErrorResult data) =>
    json.encode(data.toJson());

class SocureErrorResult {
  CapturedImages? capturedImages;
  String? errorMessage;
  String? sessionId;
  String? statusCode;

  SocureErrorResult({
    this.capturedImages,
    this.errorMessage,
    this.sessionId,
    this.statusCode,
  });

  factory SocureErrorResult.fromJson(Map<String, dynamic> json) =>
      SocureErrorResult(
        capturedImages: json["capturedImages"] == null
            ? null
            : CapturedImages.fromJson(json["capturedImages"]),
        errorMessage: json["errorMessage"],
        sessionId: json["sessionId"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "capturedImages": capturedImages?.toJson(),
        "errorMessage": errorMessage,
        "sessionId": sessionId,
        "statusCode": statusCode,
      };

  @override
  String toString() {
    return 'SocureErrorResult(capturedImages: ${capturedImages.toString()}, errorMessage: $errorMessage, sessionId: $sessionId, statusCode: $statusCode)';
  }
}

class CapturedImages {
  String? passport;
  CapturedImages({
    this.passport,
  });

  factory CapturedImages.fromJson(Map<String, dynamic> json) => CapturedImages(
        passport: json["passport"],
      );

  Map<String, dynamic> toJson() => {
        "passport": passport,
      };

  @override
  String toString() => 'CapturedImages(passport: $passport)';
}
