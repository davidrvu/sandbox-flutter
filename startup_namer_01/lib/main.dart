// FUENTE: https://flutter.dev/docs/get-started/codelab

// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart'; //SystemSound
import 'package:audioplayers/audio_cache.Dart'; // FUENTE: https://www.it-swarm.dev/es/dart/como-reproducir-un-sonido-personalizado-en-flutter/832649250/
//import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
//import 'package:clounce_loading_screen/loading_screen.dart';
import 'dart:async'; //Timer
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/animation.dart';

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
      //home: RandomWords(), // ORIGINAL
      home: SplashScreen(),

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
// LOADING SCREEN (SPLASH)
//////////////////////////////////////////////////////////////////////////
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    /////////// ANIMATION INI: FUENTE: https://medium.com/@money.prise/fade-animation-in-flutter-9f421ca24398
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
    ///////////
    Timer(
        Duration(seconds: 7),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => RandomWords())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        //child: Image.asset('assets/wolf.png'),

        //child: FadeInImage.memoryNetwork(
        //  placeholder: kTransparentImage,
        //  //fadeInDuration: Duration(milliseconds: 100),
        //  //fadeOutDuration: new Duration(milliseconds: 1500),
        //  image: 'assets/wolf.png',
        //),

        child: FadeTransition(
          opacity: animation,
          //child: Image.asset('assets/wolf.png'),
          child: Image.asset(
            'assets/dog_loading.gif',
            gaplessPlayback: true,
          ),
        ),
      ),
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

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

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
        title: Text('Startup Name Gen | ' + dateNow),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
