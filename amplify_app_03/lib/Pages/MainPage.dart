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

import 'package:intl/intl.dart'; // DateFormat
import 'package:amplify_core/amplify_core.dart';
//import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:flutter/material.dart';
import 'package:amplify_app_03/Views/ImageLineItem.dart';
import 'package:amplify_app_03/Views/ImageUploader.dart';
import 'package:amplify_app_03/Views/ChangePswView.dart';
import 'package:amplify_app_03/Views/UserView.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

class MainPage extends StatefulWidget {
  final String currentUsername;
  // receive data from the FirstScreen as a parameter
  MainPage({Key key, @required this.currentUsername}) : super(key: key);

  @override
  _MainPageState createState() =>
      _MainPageState(currentUsername: currentUsername);
}

class _MainPageState extends State<MainPage> {
  List<String> itemKeys = new List<String>();

  final String currentUsername;
  _MainPageState({Key key, @required this.currentUsername});

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

  @override
  void initState() {
    super.initState();
    _loadImages();
    //getPosition();
  }

  //String altitudVar;
  String altitudVar = "test";

  void getPosition() async {
    try {
      //bool isLocationServiceEnabled;
      //isLocationServiceEnabled = await isLocationServiceEnabled();
      PermissionStatus permission =
          await LocationPermissions().requestPermissions();
      LocationPermission permission1 = await requestPermission();
      LocationPermission permission2 = await checkPermission();
      print("permission1 = " + permission1.toString());
      print("permission2 = " + permission2.toString());

      Position positionNow =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      altitudVar = positionNow.altitude.toString();
      print("Altitud  = " + positionNow.altitude.toString());
      print("Latitud  = " + positionNow.latitude.toString());
      print("Longitud = " + positionNow.longitude.toString());
    } catch (e) {
      print("ERROR de getCurrentPosition = " + e.toString());
      altitudVar = "";
    }
  }

  void _loadImages() async {
    try {
      print('In list');
      //  S3ListOptions options =
      //      S3ListOptions(accessLevel: StorageAccessLevel.guest);
      //  ListResult result = await Amplify.Storage.list(options: options);

      var newList = itemKeys.toList();
      //  for (StorageItem item in result.items) {
      //    newList.add(item.key);
      //  }

      setState(() {
        itemKeys = newList;
      });
    } catch (e) {
      print('List Err: ' + e.toString());
    }
  }

  void _showImageUploader() async {
    String key = await showDialog(
        context: context,
        child: new SimpleDialog(
            title: Text("Upload Image"), children: [ImageUploader()]));

    if (key.isNotEmpty) {
      var newList = itemKeys.toList();
      newList.add(key);

      setState(() {
        itemKeys = newList;
      });
    }
  }

  void _createEventPinpoint() {
    // FUENTE https://medium.com/@vennify.education/flutter-apps-with-aws-backend-part-3-analytics-bdb8b5bad5c0
    // simply logs a test event
    AnalyticsEvent event = AnalyticsEvent("test_event");

    event.properties.addBoolProperty("boolKey", true);
    event.properties.addDoubleProperty("doubleKey", 10.0);
    event.properties.addIntProperty("intKey", 10);
    event.properties.addStringProperty("stringKey", "stringValue");

    Amplify.Analytics.recordEvent(event: event);
    Amplify.Analytics.flushEvents();

    print("event logged");
  }

  @override
  Widget build(BuildContext context) {
    print("Bienvenido: " + currentUsername);
    DateTime datetimeNow = new DateTime.now();
    //DateTime date = new DateTime(now.year, now.month, now.day);
    var formatterDateTime = new DateFormat('yyyy-MM-dd hh:mm:ss');
    String dateTimeNow = formatterDateTime.format(datetimeNow);

    return Scaffold(
      appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text("Main Page !!"), UserView()])),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Bienvenido: " + currentUsername,
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              child: Text(
                dateTimeNow,
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              child: Text(
                "Altitud = " + altitudVar,
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              child: openDialogButton(
                  "Change Password",
                  (oldPassword) => {print("Update password success!")},
                  ChangePswView()),
            ),
            Container(
              child: RaisedButton(
                onPressed: _createEventPinpoint,
                child: Text("Create Event Pinpoint"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//ListView.builder(
//    itemCount: itemKeys.length,
//    itemBuilder: (context, index) {
//      return ImageLineItem(storageKey: itemKeys[index]);
//    }),
//floatingActionButton: FloatingActionButton(
//  onPressed: () {
//    //_showImageUploader();
//  },
//  tooltip: 'Increment',
//  child: Icon(Icons.add),
