/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

import 'package:flutter/material.dart';

import '../Views/SignInView.dart';
import '../Views/SignUpView.dart';
import 'MainPage.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Future<Null> _showDialogForResult(
      String text, Function onSuccess, Widget dialogWidget) async {
    List result = await showDialog(
      context: context,
      child: new SimpleDialog(
        title: Text(text),
        children: [
          dialogWidget,
          RaisedButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context, [false, ""]);
            },
          ),
        ],
      ),
    );
    if (result[0]) onSuccess(result[1]);
  }

  // dialogWidget must return true or false
  Widget openDialogButton(
      String text, Function onSuccess, Widget dialogWidget) {
    return RaisedButton(
        child: Text(text),
        onPressed: () {
          _showDialogForResult(text, onSuccess, dialogWidget);
        });
  }

  void onSignInSuccess(currentUsername) {
    print("Sign In exitoso! :)");
    print("USUARIO = " + currentUsername);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MainPage(currentUsername: currentUsername)),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Landing Page"),
        ),
        body: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            openDialogButton("Sign In", onSignInSuccess, SignInView()),
            openDialogButton(
                "Sign Up",
                (userName) => {print("sign up success userName = " + userName)},
                SignUpView())
          ],
        )));
  }
}