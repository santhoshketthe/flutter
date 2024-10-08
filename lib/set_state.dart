import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Increment"),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(20),
                child: Text('Count: $_count')),
            Container(
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                key: const Key('incrementButton'),
                  onPressed: _increment, child: const Text('Increment')),
            ),
            Container(
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                  key: const Key('decrementButton'),
                    onPressed: _decrement, child: const Text('decrement')))
          ],
        )));
  }
}
