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
import 'package:flutter/material.dart';
import 'package:amplify_app_03/Views/ImageLineItem.dart';
import 'package:amplify_app_03/Views/ImageUploader.dart';
import 'package:amplify_app_03/Views/UserView.dart';

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

  @override
  void initState() {
    super.initState();
    _loadImages();
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
      body: Column(
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
        ],
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
