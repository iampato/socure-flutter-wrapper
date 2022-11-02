import 'package:flutter/material.dart';
import 'package:socure/socure.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _socurePlugin = Socure();

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text('Running'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String key = "c488debf-1017-4423-8e4d-ea35a89337b3";
            await _socurePlugin.launchSocure(
              sdkKey: key,
              onSuccess: (successResult) {
                debugPrint("%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                print(successResult.toString());
                debugPrint("%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
              },
              onError: (errorResult) {
                debugPrint("*****************");
                print(errorResult.toString());
                debugPrint("*****************");
              },
            );
          },
        ),
      ),
    );
  }
}
