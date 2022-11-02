// To parse this JSON data, do
//
//     final socureSuccessResult = socureSuccessResultFromJson(jsonString);

import 'dart:convert';

SocureSuccessResult socureSuccessResultFromJson(String str) =>
    SocureSuccessResult.fromJson(json.decode(str));

String socureSuccessResultToJson(SocureSuccessResult data) =>
    json.encode(data.toJson());

class SocureSuccessResult {
  String? docUuid;
  String? sessionId;
  ExtractedData? extractedData;
  Capture? captureData;
  Capture? capturedImages;

  SocureSuccessResult({
    this.docUuid,
    this.sessionId,
    this.extractedData,
    this.captureData,
    this.capturedImages,
  });

  factory SocureSuccessResult.fromJson(Map<String, dynamic> json) =>
      SocureSuccessResult(
        docUuid: json["docUUID"],
        sessionId: json["sessionId"],
        extractedData: json["extractedData"] == null
            ? null
            : ExtractedData.fromJson(json["extractedData"]),
        captureData: json["captureData"] == null
            ? null
            : Capture.fromJson(json["captureData"]),
        capturedImages: json["capturedImages"] == null
            ? null
            : Capture.fromJson(json["capturedImages"]),
      );

  Map<String, dynamic> toJson() => {
        "docUUID": docUuid,
        "sessionId": sessionId,
        "extractedData": extractedData?.toJson(),
        "captureData": captureData?.toJson(),
        "capturedImages": capturedImages?.toJson(),
      };

  @override
  String toString() {
    return 'SocureSuccessResult(docUuid: $docUuid, sessionId: $sessionId, extractedData: $extractedData, captureData: $captureData, capturedImages: $capturedImages)';
  }
}

class Capture {
  String? licFront;
  String? licBack;
  String? passport;
  String? selfie;

  Capture({
    this.licFront,
    this.licBack,
    this.passport,
    this.selfie,
  });

  factory Capture.fromJson(Map<String, dynamic> json) => Capture(
        licFront: json["lic_front"],
        licBack: json["lic_back"],
        passport: json["passport"],
        selfie: json["selfie"],
      );

  Map<String, dynamic> toJson() => {
        "lic_front": licFront,
        "lic_back": licBack,
        "passport": passport,
        "selfie": selfie,
      };

  @override
  String toString() {
    return 'Capture(licFront: $licFront, licBack: $licBack, passport: $passport, selfie: $selfie)';
  }
}

class ExtractedData {
  String? address;
  String? issueDate;
  ParsedAddress? parsedAddress;
  String? dob;
  String? documentNumber;
  String? expirationDate;
  String? firstName;
  String? fullName;
  String? type;

  ExtractedData({
    this.address,
    this.issueDate,
    this.parsedAddress,
    this.dob,
    this.documentNumber,
    this.expirationDate,
    this.firstName,
    this.fullName,
    this.type,
  });

  factory ExtractedData.fromJson(Map<String, dynamic> json) => ExtractedData(
        address: json["address"],
        issueDate: json["issueDate"],
        parsedAddress: json["parsedAddress"] == null
            ? null
            : ParsedAddress.fromJson(json["parsedAddress"]),
        dob: json["dob"],
        documentNumber: json["documentNumber"],
        expirationDate: json["expirationDate"],
        firstName: json["firstName"],
        fullName: json["fullName"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "issueDate": issueDate,
        "parsedAddress": parsedAddress?.toJson(),
        "dob": dob,
        "documentNumber": documentNumber,
        "expirationDate": expirationDate,
        "firstName": firstName,
        "fullName": fullName,
        "type": type,
      };

  @override
  String toString() {
    return 'ExtractedData(address: $address, issueDate: $issueDate, parsedAddress: $parsedAddress, dob: $dob, documentNumber: $documentNumber, expirationDate: $expirationDate, firstName: $firstName, fullName: $fullName, type: $type)';
  }
}

class ParsedAddress {
  String? city;
  String? country;
  String? physicalAddress;
  String? physicalAddress2;
  String? postalCode;
  String? state;

  ParsedAddress({
    this.city,
    this.country,
    this.physicalAddress,
    this.physicalAddress2,
    this.postalCode,
    this.state,
  });

  factory ParsedAddress.fromJson(Map<String, dynamic> json) => ParsedAddress(
        city: json["city"],
        country: json["country"],
        physicalAddress: json["physicalAddress"],
        physicalAddress2: json["physicalAddress2"],
        postalCode: json["postalCode"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "physicalAddress": physicalAddress,
        "physicalAddress2": physicalAddress2,
        "postalCode": postalCode,
        "state": state,
      };

  @override
  String toString() {
    return 'ParsedAddress(city: $city, country: $country, physicalAddress: $physicalAddress, physicalAddress2: $physicalAddress2, postalCode: $postalCode, state: $state)';
  }
}
