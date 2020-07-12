// FUENTE: https://flutter.dev/docs/get-started/codelab

// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    DateTime datetimeNow = new DateTime.now();
    //DateTime date = new DateTime(now.year, now.month, now.day);
    var formatterDate = new DateFormat('yyyy-MM-dd');
    String dateNow = formatterDate.format(datetimeNow);
    return MaterialApp(
      title: 'Welcome to Flutter !!!!',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      debugShowCheckedModeBanner: false, // DAVIDRVU: Para sacar DEBUG BANNER!
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bienvenido a Flutter " + dateNow.toString()),
        ),
        body: Center(
          //child: Text('Hola Mundo!!! 123'),
          child: Text(wordPair.asPascalCase),
        ),
      ),
    );
  }
}
