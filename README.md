# Predictive DocV SDK v3 Flutter

The Predictive Document Verification (DocV) SDK v3 for Flutter is a Flutter wrapper that allows you to use the DocV SDK for Android and iOS in your Flutter application.

## Minimum Requirements

**iOS**

- Support for iOS 13 and later
- Xcode version 13+

**Android**

- Android SDK Version 22 (OS Version 5.1) and later
- Android SDK is compiled with `compileSdkVersion` 32 and Java 11

## Install
on your `pubspec.yaml`
```
socure:
      git:
        url: https://github.com/iampato/socure-flutter-wrapper.git
        ref: develop
```

## Getting Started

### Android
1. Configure your Android app

   For the Android app, add your project dependencies by going to the module level `build.gradle` file and making sure the `minSdkVersion` is set to at least 22 and the `compileSdkVersion` is set to at least 32.
    ```kotlin {5,6}
    buildscript {
                  .....
                ext {
                     ....
                    minSdkVersion = 22 
                    compileSdkVersion = 32
                    .....
                }
    }
    ```
2. Permissions

   Ensure that your app manifest has been set up properly to request the following required permissions:
    ```
    <uses-feature android:name="android.hardware.camera" />
    
    <!-- Declare permissions -->
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    ```

### ios
1. Permissions
   
    add the following in your `ios/runner/info.plist`
    ```
    <key>NSCameraUsageDescription</key>
    <string>$(PRODUCT_NAME) camera description.</string>
    ```

2. Minimum ios version
   
    In your `Podfile`
    uncomment the second line and set it to `13.0` or higher
    ```
    platform :ios, '13.0'
    ```


## How it works

Your Flutter application initializes and communicates with the DocV SDK through the Flutter wrapper using the `launchSocure` instance.

The following table lists the available `launchSocure` properties:

| Argument           | Description                                                                                                                                                                                                                                                                                                       |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `sdkKey`   | The unique SDK key obtained from Admin Dashboard. For more information on SDK keys, see the [Getting Started](https://developer.socure.com/docs/) article.                                                                                                                          |
| `flow`           | An optional JSON string or null value that specifies a custom flow. The `FLOW_NAME` value specifies the name of the flow (created in Admin Dashboard) that the DocV SDK should use.  <br /> <br />`JSON.stringify({flow: {name: “FLOW_NAME”}})` <br /> <br />If the value is `null`, the DocV SDK will fetch the default flow from Admin Dashboard. |  |   |
| `onSuccess`      | A callback function that notifies you when the flow completes successfully.                                                                                                                                                                                                                                                                                               |   |   |
| `onError`        | A callback function that notifies you when the flow fails.                                                                                                                                                                                                                                                                                                |   |   |


## Response callbacks

Your app can receive a response callback from the Socure DocV SDK when the flow completes successfully or returns with an error using the `onSuccess` and `onError` callback functions.

### `onSuccess` response
When the consumer successfully completes the flow and the captured images are uploaded, the `onSuccess` callback receives the ScannedData object which contains session information and the extracted data. The table below lists the available `ScannedData` properties.
Note that all these fields are optional

| Result Field   | Type        | Description                                                                                                                                                                                          |
|----------------|-------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `docUUID`        | string      | The UUID for the uploaded scanned images.                                                                                                                                                             |
| `sessionId`      | string      | The session ID for the scan session.                                                                                                                                                                 |
| `extractedData`  | JSON object | Contains extractedInfo from the barcode or MRZ.                                                                                                                                                      |
| `captureData`    | JSON object | The mapped capture type for every scan. <br /> Possible keys are: `lic_front`, `lic_back`, `passport`, `selfie` <br /> Possible values can be `manual` or `auto`                                                              |
| `capturedImages` | JSON object | The mapped image data of captured images. <br /> Possible keys are: `lic_front`, `lic_back`, `passport`, `selfie` <br />  Value will be a base64 image string <br />**Note**: Prefix `data:image/png;base64,` while using base64 string. |

#### Sample `onSuccess` response
```json
{
  "docUUID": "UUID for the uploaded scanned images",
  "sessionId": "Session ID for the particular scan session",
  "extractedData": {
    "address": "123 TAYLOR AVE",
    "issueDate": "09282007",
    "parsedAddress": {
      "city": "SAN BRUNO",
      "country": "USA",
      "physicalAddress": "123 TAYLOR AVE",
      "physicalAddress2": "SAN BRUNO",
      "postalCode": "940660000",
      "state": "CA"
    },
    "dob": "07221977",
    "documentNumber": "D12345",
    "expirationDate": "07222022",
    "firstName": "SAM",
    "fullName": "SAM SOTO",
    "type": "barcode"
  },
  "captureData": {
    "lic_front": "auto",
    "lic_back": "auto",
    "passport": "auto",
    "selfie": "manual"
  },
  "capturedImages": {
    "lic_front": "base64 Image as String",
    "lic_back": "base64 Image as String",
    "selfie": "base64 Image as String"
  }
}
```

### `onError` response

If the consumer exits the flow without completing it or the SDK encounters an error, the `onError` callback receives the `ScanError` object which contains session information and the error. The table below lists the available `ScanError` properties.

| Error Field    | Type        | Description                                                                                                                                                                                                          |
|----------------|-------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `capturedImages` | JSON object | The mapped image data of captured images (if available). <br /> Possible keys are: `lic_front`, `lic_back`, `passport`, `selfie` <br /> Value will be a base64 image string <br /> **Note**: Prefix `data:image/png;base64,` while using base64 string. |
| `errorMessage`   | string      | The error code description.                                                                                                                                                                                          |
| `sessionId`      | string      | The session ID for the particular scan session.                                                                                                                                                                      |
| `statusCode`     | string      | The error code returned by Socure DocV SDK.                                                                                                                                                                          |

#### Sample `onError` response
```json
{
  "capturedImages": {
    "passport": "base64 Image as String"
  },
  "errorMessage": "Scan canceled by the user",
  "sessionId": "2a55f9-42bgfa-4fb3-9gf32e-6a6fec5",
  "statusCode": "7104"
}
```

### Error codes

The following table lists the errors that can be returned by Socure DocV SDK:

| Error Code | Error Description (string)                              |
| ---------- | ------------------------------------------------------- |
| `7011`       | `Invalid key`                                             |
| `7021`       | `Failed to initiate the session `                         |
| `7014`       | `Session expired   `                                      |
| `7101`       | `Empty key `                                              |
| `7103`       | `No internet connection  `                                |
| `7102`       | `Do not have the required permissions to open the camera` |
| `7022`       | `Failed to upload the documents `                         |
| `7104`       | `Scan canceled by the user`                               |
| `7106`       | `Camera error`                                            |
| `7107`       | `Unknown error`                                           |
| `7108`       | `Camera resolution doesn't match the minimum requirement` |
| `7109`       | `Invalid config data`                                     |
| `7110`       | `Consent declined`                                        |