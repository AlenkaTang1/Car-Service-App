import 'package:flutter/material.dart';

class RecallPage extends StatefulWidget {
  const RecallPage({super.key});

  @override
  State<StatefulWidget> createState() => _RecallPageState();
}

class _RecallPageState extends State<RecallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recall Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
