// FUENTE: https://github.com/aws-amplify/amplify-flutter/blob/master/example/lib/main.dart
// FUENTE: https://docs.amplify.aws/lib/project-setup/create-application/q/platform/flutter#n4-initialize-amplify-in-the-application
// FUENTE: https://docs.amplify.aws/lib/auth/signin/q/platform/flutter#prerequisites
// PARA VER ESTADÍSTICAS: >amplify console analytics

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
// Amplify Flutter Packages
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

// Generated in previous step
import 'amplifyconfiguration.dart';

import 'package:amplify_app_03/Pages/LoadingPage.dart';
import 'Pages/LandingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Amplify amplify = Amplify();
  bool _isAmplifyConfigured = false;

  @override
  initState() {
    super.initState();
    _initAmplifyFlutter();
  }

  void _initAmplifyFlutter() async {
    AmplifyAuthCognito auth = AmplifyAuthCognito();
    //AmplifyStorageS3 storage = AmplifyStorageS3();
    AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();

    amplify.addPlugin(
      authPlugins: [auth],
      //storagePlugins: [storage],
      analyticsPlugins: [analyticsPlugin],
    );

    // Initialize AmplifyFlutter
    await amplify.configure(amplifyconfig);

    setState(() {
      _isAmplifyConfigured = true;
    });
  }

  Widget _display() {
    if (_isAmplifyConfigured) {
      print("LandingPage()");
      return LandingPage();
    } else {
      print("LoadingPage()");
      return LoadingPage();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Amplify App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _display());
  }
}
