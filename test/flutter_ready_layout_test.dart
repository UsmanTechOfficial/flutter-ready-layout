import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_ready_layout/flutter_ready_layout.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TestWidget callback runs exactly once after first layout',
      (WidgetTester tester) async {
    int runCount = 0;

    // Pump our TestWidget; the mixin should fire its callback once.
    await tester.pumpWidget(TestWidget(callback: () => runCount++));

    // afterFirstLayout should have been called exactly once.
    expect(runCount, 1);

    // Pump again to simulate an additional frame—
    // the mixin must NOT fire a second time.
    await tester.pump();
    expect(runCount, 1);
  });
}

@immutable
class TestWidget extends StatefulWidget {
  const TestWidget({super.key, required this.callback});

  final VoidCallback callback;

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget>
    with ReadyLayoutMixin<TestWidget> {
  @override
  Widget build(BuildContext context) => Container();

  @override
  FutureOr<void> onViewReady(BuildContext context) {
    widget.callback();
  }
}
