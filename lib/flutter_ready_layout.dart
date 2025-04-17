library;

import 'dart:async';

import 'package:flutter/widgets.dart';

/// A mixin that provides a hook which is called exactly once,
/// immediately after this [State]’s first layout/build/frame is complete.
///
/// This is useful for scenarios where you need to do something
/// that depends on having a fully laid‑out widget tree—such as:
/// - Measuring the rendered size of a widget via its [RenderObject].
/// - Starting an animation that needs final layout dimensions.
/// - Adjusting scroll positions or other post‑layout effects.
///
/// Simply mix this into your [State] subclass and implement
/// [onViewReady], which will be invoked right after Flutter
/// finishes laying out, painting, and compositing the first frame.
///
/// ## Usage
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter__ready/flutter_layout_ready.dart';
///
/// class MyMeasuredWidget extends StatefulWidget {
///   @override
///   _MyMeasuredWidgetState createState() => _MyMeasuredWidgetState();
/// }
///
/// class _MyMeasuredWidgetState extends State<MyMeasuredWidget>
///     with LayoutReadyMixin<MyMeasuredWidget> {
///   double? _height;
///
///   @override
///   FutureOr<void> afterFirstLayout(BuildContext context) {
///     // Widget is now laid out. We can safely measure it.
///     final box = context.findRenderObject() as RenderBox;
///     setState(() {
///       _height = box.size.height;
///     });
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Container(
///       color: Colors.blueAccent,
///       height: 200,
///       child: Center(
///         child: Text(
///           _height == null
///               ? 'Calculating height...'
///               : 'Height: ${_height!.toStringAsFixed(1)} px',
///           style: TextStyle(color: Colors.white),
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// **Note**: This callback is invoked only once per widget instance,
/// after the very first frame. If you need to react to subsequent
/// layout changes you will need to use other mechanisms like
/// [LayoutBuilder], [WidgetsBinding.instance.addPostFrameCallback],
/// or listening to [RenderObject] changes directly.
mixin ReadyLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    // Schedule a callback for the end of this frame.
    WidgetsBinding.instance.endOfFrame.then((_) {
      // Only call if the State object is still in the tree.
      if (!mounted) return;
      onViewReady(context);
    });
  }

  /// Called exactly once, immediately after this State’s first
  /// layout/build/frame has completed.
  ///
  /// The [BuildContext] is fully laid out and rendered, so you can:
  /// - Use `context.findRenderObject()` to inspect size/position.
  /// - Kick off animations that depend on actual widget dimensions.
  /// - Scroll to a particular offset on a [ScrollController].
  ///
  /// You may implement this method as `async` if you prefer `await`
  /// syntax for more complex initialization.
  FutureOr<void> onViewReady(BuildContext context);
}
