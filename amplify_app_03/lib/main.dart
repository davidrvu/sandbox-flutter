// FUENTE: https://github.com/aws-amplify/amplify-flutter/blob/master/example/lib/main.dart

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
// Amplify Flutter Packages
import 'package:amplify_core/amplify_core.dart';
//import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

// Generated in previous step
import 'amplifyconfiguration.dart';

import 'package:amplify_app_03/Pages/LoadingPage.dart';
import 'Pages/LandingPage.dart';

void main() {
  runApp(MyApp());
}

//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//        // This makes the visual density adapt to the platform that you run
//        // the app on. For desktop platforms, the controls will be smaller and
//        // closer together (more dense) than on mobile platforms.
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  // FUENTE: https://docs.amplify.aws/lib/project-setup/create-application/q/platform/flutter#n4-initialize-amplify-in-the-application
//  bool _amplifyConfigured = false;
//  Amplify amplifyInstance = Amplify();
//
//  @override
//  initState() {
//    super.initState();
//    _configureAmplify();
//  }
//
//  void _configureAmplify() async {
//    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
//    //AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
//    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
//    amplifyInstance.addPlugin(authPlugins: [authPlugin]);
//    //amplifyInstance.addPlugin(analyticsPlugins: [analyticsPlugin]);
//
//    // Once Plugins are added, configure Amplify
//    await amplifyInstance.configure(amplifyconfig);
//    try {
//      setState(() {
//        _amplifyConfigured = true;
//      });
//    } catch (e) {
//      print(e);
//    }
//
//    /////////////////////////////////////////////////////////////////////////
//    /// FUENTE: https://docs.amplify.aws/lib/auth/signin/q/platform/flutter#prerequisites
//    /////////////////////////////////////////////////////////////////////////
//    var isSignUpComplete;
//    try {
//      Map<String, dynamic> userAttributes = {
//        "email": "appmopit@gmail.com",
//        "phone_number": "+56977783703",
//        // additional attributes as needed
//      };
//      SignUpResult res = await Amplify.Auth.signUp(
//          username: "myusername_DANIEL",
//          password: "mysupersecurepassword",
//          options: CognitoSignUpOptions(userAttributes: userAttributes));
//      setState(() {
//        isSignUpComplete = res.isSignUpComplete;
//      });
//    } on AuthError catch (e) {
//      print(e);
//    }
//
//    print("Nombre de usuario, contraseña y email ingresados!");
//
//    print('Confirmation Code = ');
//    var confirmCodeStr =
//        stdin.readLineSync(encoding: Encoding.getByName('utf-8'));
//
//    try {
//      SignUpResult res = await Amplify.Auth.confirmSignUp(
//          username: "myusername_deiwi", confirmationCode: confirmCodeStr);
//      setState(() {
//        isSignUpComplete = res.isSignUpComplete;
//      });
//    } on AuthError catch (e) {
//      print(e);
//    }
//    print("----Confirm signUp succeeded ??");
//    // Confirm signUp succeeded
//  }
//
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: Column(
//          // Column is also a layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.headline4,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
//

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
    //AmplifyAnalyticsPinpoint analytics = AmplifyAnalyticsPinpoint();

    amplify.addPlugin(
      authPlugins: [auth],
      //storagePlugins: [storage],
      //analyticsPlugins: [analytics]
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
