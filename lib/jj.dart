import 'package:flutter/material.dart';

import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Future<bool>? _randomBoolFuture;

  @override
  void initState() {
    super.initState();
    _randomBoolFuture = authlogin();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _randomBoolFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Scaffold(body: Text('Error: ${snapshot.error}'));
            } else {
              return ChildHandler(
                snapshot: snapshot,
                refresh: () {
                  setState(() {
                    _randomBoolFuture = refresh();
                  });
                },
              );
            }
        }
      },
    );
  }

  Future<bool> authlogin() async {
    final random = Random();
    print("here i am authlogin");
    return Future.delayed(
        const Duration(milliseconds: 400), () => random.nextBool());
  }

  Future<bool> refresh() async {
    final random = Random();
    print("here i am refresh");
    return Future.delayed(
        const Duration(milliseconds: 400), () => random.nextBool());
  }
}

class ChildHandler extends StatelessWidget {
  final AsyncSnapshot<bool> snapshot;
  final VoidCallback refresh;

  const ChildHandler(
      {super.key, required this.snapshot, required this.refresh});

  Widget _buildPopup() {
    return AlertDialog(
      title: const Text('Condition Met'),
      content: const Text('This is the popup content'),
      actions: [
        TextButton(
          onPressed: () {
            refresh.call();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget _buildSubWiget() {
    // Your sub widget content to be returned when the condition is not met
    return Scaffold(body: _buildPopup());
  }

  Widget _buildMainWidget(BuildContext context) {
    // Your main widget content to be returned when the condition is not met
    return const Scaffold(body: Text('This is the main widget content'));
  }

  @override
  Widget build(BuildContext context) {
    bool showPopup = snapshot.data ?? false;
    return showPopup ? _buildSubWiget() : _buildMainWidget(context);
  }
}
