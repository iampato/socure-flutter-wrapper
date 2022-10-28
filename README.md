# socure

A new Flutter project.

## Install
on your `pubspec.yaml`
```
socure:
      git:
        url: https://github.com/iampato/socure-flutter-wrapper.git
```

## Getting Started

### Android

Under your `android/` folder navigate to the MainActivity of the application and the following codebase
```kotlin
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
    }
```

so that your `MainActivity` looks like this
```kotlin
class MainActivity: FlutterActivity() {
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
    }
}
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

