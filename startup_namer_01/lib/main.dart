// FUENTE: https://flutter.dev/docs/get-started/codelab

// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart'; //SystemSound
import 'package:audioplayers/audio_cache.Dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
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
      home: RandomWords(),
      //home: Scaffold(
      //  appBar: AppBar(
      //    title: Text("Bienvenido a Flutter " + dateNow.toString()),
      //  ),
      //  body: Center(
      //    //child: Text('Hola Mundo!!! 123'),
      //    //child: Text(wordPair.asPascalCase),
      //    child: RandomWords(),
      //  ),
      //),
    );
  }
}

//////////////////////////////////////////////////////////////////////////
// STATEFUL WIDGET
//////////////////////////////////////////////////////////////////////////
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>(); // NEW
  final _biggerFont = TextStyle(fontSize: 18.0);

  static AudioCache player = new AudioCache();

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        //style: _biggerFont,
        //style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
        //style: TextStyle(fontWeight: FontWeight.bold),
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationColor: Colors.green,
          decorationThickness: 2,
          decorationStyle: TextDecorationStyle.wavy,
        ),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.green : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            player.play("r2d2_sad.mp3");
            _saved.remove(pair);
          } else {
            SystemSound.play(SystemSoundType.click);
            player.play("r2d2_beep.mp3");
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime datetimeNow = new DateTime.now();
    var formatterDate = new DateFormat('yyyy-MM-dd');
    String dateNow = formatterDate.format(datetimeNow);

    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator | ' + dateNow),
      ),
      body: _buildSuggestions(),
    );
  }
}
