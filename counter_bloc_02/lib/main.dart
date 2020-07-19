// DAVIDRVU - 2020
// FUENTE: https://www.youtube.com/watch?v=knMvKPKBzGE  (FLUTTER EUROPE)
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// En caso de crear package
//import 'package:counter_bloc_02/counter_bloc_02.dart'

enum CounterEvent { increment, decrement }

//                             input,        output
class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  // output,                               input
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.decrement:
        yield state - 1;
        break;
    }
  }
}
/////////////////////////////////////////////////////////////////

void main() {
  // SOLO TESTING
  //final counterBloc_examp = CounterBloc();
  //counterBloc_examp.listen(print);
  //counterBloc_examp.add(CounterEvent.increment);
  //counterBloc_examp.add(CounterEvent.decrement);

  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBlocExamp = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Counter with Bloc - DRVU 2020")),
      body: Center(
        //                 MyBloc,      MyState
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            // Return a widget based on MyState
            return Text("You have pushed the button $state times.",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center);
          },
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => counterBlocExamp.add(CounterEvent.increment),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () => counterBlocExamp.add(CounterEvent.decrement),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
