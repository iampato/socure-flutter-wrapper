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
