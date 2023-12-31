import 'package:flutter/material.dart';

import 'tricky_widget.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tricky Widget')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: TrickyWidget(
            text: 'My Beretta stirred nervously under my coat',
            isChecked: true,
          ),
        ),
      ),
    );
  }
}
