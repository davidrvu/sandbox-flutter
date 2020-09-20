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

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';

import 'ErrorView.dart';

class ChangePswView extends StatefulWidget {
  @override
  _ChangePswViewState createState() => _ChangePswViewState();
}

class _ChangePswViewState extends State<ChangePswView> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();

  String _updatePswError = "";
  List<String> _updatePswExceptions = [];

  @override
  void initState() {
    super.initState();
  }

  void _updatePsw() async {
    try {
      String oldPassword = oldPassController.text.trim();
      String newPassword = newPassController.text.trim();

      await Amplify.Auth.updatePassword(
          newPassword: newPassword, oldPassword: oldPassword);

      Navigator.pop(context, [true, oldPassword]);
    } on AuthError catch (e) {
      setState(() {
        _updatePswError = e.cause;
        _updatePswExceptions.clear();
        e.exceptionList.forEach((el) {
          _updatePswExceptions.add(el.exception);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          // wrap your Column in Expanded
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: oldPassController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter your current password',
                    labelText: 'Current password *',
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  controller: newPassController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Enter your new password',
                    labelText: 'New Password *',
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10.0)),
                RaisedButton(
                  onPressed: _updatePsw,
                  child: const Text('Update Password'),
                ),
                ErrorView(_updatePswError, _updatePswExceptions)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
