import 'package:flutter/material.dart';
import 'package:flutter_ready_layout/flutter_ready_layout.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(title: 'Simple Async Example'),
    ),
  );
}

class MyApp extends StatefulWidget {
  final String title;

  const MyApp({
    super.key,
    required this.title,
  });

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with ReadyLayoutMixin<MyApp> {
  String _message = 'Loading...';

  /// ✕ Attempting to make [initState] async will cause a compile‑time error.
  ///
  /// ```dart
  /// @override
  /// Future<void> initState() async {
  ///   super.initState();
  ///   await Future.delayed(const Duration(seconds: 2));
  /// }
  /// ```
  ///
  /// **Error:**
  /// ```
  /// The type 'Future<void>' of initState isn't a valid override of 'void Function()'.
  /// ```

  // Do not perform async work here—use `onViewReady` instead.

  /// Performs the asynchronous operation.
  @override
  Future<void> onViewReady(BuildContext context) async {
    final message = await _loadData();
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(_message),
      ),
    );
  }

  Future<String> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Async operation complete';
  }
}
