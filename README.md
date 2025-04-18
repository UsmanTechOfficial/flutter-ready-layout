###  📐 Flutter `ReadyLayoutMixin` — Execute Code After First Layout

Sometimes in Flutter, you need to perform certain actions only **after**
the widget has been fully built and laid out — for example, to:


- Start async tasks right after the UI is ready.
- Get the size of a widget (like its height or width).
- Start animations that need to know the size of something.
- Move or control scroll position after layout.
- Automatically scroll to a widget or list item.
- Update state only after the layout is done.


Make sure a widget is actually visible on the screen.


This is where `ReadyLayoutMixin` comes in handy. It ensures your code
runs exactly once **after the first layout is complete**.

---
---

## ❌ Without `ReadyLayoutMixin`
### Example

 ```dart
class SetStateExample extends StatefulWidget {
  @override
  State<SetStateExample> createState() => _SetStateExampleState();
}

class _SetStateExample extends State<SetStateExample> {
  String label = 'Before layout';

  @override
  void initState() {
    super.initState();
    // ❌ This will throw an error if it triggers a rebuild too early
    setState(() {
      label = 'Trying to update too soon!';
    });
  }

  @override
  Widget build(BuildContext context) => Text(label);
}
 ```


### ✅ With `ReadyLayoutMixin`

Use this approach to simplify post-layout logic without having to
manage frame callbacks manually.

### Example

 ```dart
class SetStateExample extends StatefulWidget {
  @override
  State<SetStateExample> createState() => _SetStateExampleState();
}

class _SetStateExampleState extends State<SetStateExample>
    with ReadyLayoutMixin<SetStateExample> {
  String label = 'Before layout';

  @override
  void onViewReady(BuildContext context) {
    setState(() {
      label = 'Layout is ready!';
    });
  }

  @override
  Widget build(BuildContext context) => Text(label);
}


 ```

 ---

 ---

### ❌ Without `ReadyLayoutMixin`

### Example

 ```dart
class AsyncExample extends StatefulWidget {
  @override
  State<AsyncExample> createState() => _AsyncExampleState();
}

class _AsyncExampleState extends State<AsyncExample> {
  String label = 'Loading...';

  @override
  Future<void> initState() async{
    super.initState();
    // ❌ This will throw an error on Asynchronous operation.
    await _doAsyncWork();
  }

  Future<void> _doAsyncWork() async {
    await Future.delayed(Duration(seconds: 2));
    if (mounted) {
      setState(() {
        label = 'Data loaded after layout!';
      });
    }
  }

  @override
  Widget build(BuildContext context) => Text(label);
}

 ```

 ---


### ✅ With `ReadyLayoutMixin`

Use this approach to simplify post-layout logic without having to
manage frame callbacks manually.

### Example

 ```dart
class AsyncExample extends StatefulWidget {
  @override
  State<AsyncExample> createState() => _AsyncExampleState();
}

class _AsyncExampleState extends State<AsyncExample>
    with ReadyLayoutMixin<AsyncExample> {
  String label = 'Loading...';

  @override
  Future<void> onViewReady(BuildContext context) async {
    // Do your async logic here
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      label = 'Data loaded after layout!';
    });
  }

  @override
  Widget build(BuildContext context) => Text(label);
}

 ```