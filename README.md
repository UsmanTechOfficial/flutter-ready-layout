# 📐 Flutter `ReadyLayoutMixin` — Execute Code After First Layout

Sometimes in Flutter, you need to perform certain actions only **after**
the widget has been fully built and laid out — for example, to:


- Start async tasks right after the UI is ready.
- Get the size of a widget (like its height or width).
- Check layout info, like where a widget is placed.
- Start animations that need to know the size of something.
- Move or control scroll position after layout.
- Automatically scroll to a widget or list item.
- Update state only after the layout is done.
- Figure out how much space a widget has.
- Use low-level tools to get widget boundaries.
- Set up services or dependencies that depend on layout.
- Begin custom drawing once everything is on screen.
- Send tracking info once layout is finished.


Make sure a widget is actually visible on the screen.


This is where `ReadyLayoutMixin` comes in handy. It ensures your code
runs exactly once **after the first layout is complete**.

 ---

## ✅ With `ReadyLayoutMixin`

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

## ❌ Without `ReadyLayoutMixin`

If you're not using the mixin, you'll need to manually schedule a
callback using `WidgetsBinding.instance.addPostFrameCallback`.

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

 ---

 ---

## ✅ With `ReadyLayoutMixin`

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

 ---

## ❌ Without `ReadyLayoutMixin`

If you're not using the mixin, you'll need to manually schedule a
callback using `WidgetsBinding.instance.addPostFrameCallback`.

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



## 🧠 Summary

| Feature                     | With `ReadyLayoutMixin`           | Without Mixin (Manual)             |
 |----------------------------|-----------------------------------|------------------------------------|
| Simplicity                 | ✅ Clean, one method               | ❌ Requires boilerplate             |
| Automatic frame hook       | ✅ Built-in after-layout logic     | ❌ Manual post-frame logic needed   |
| Reusability                | ✅ Easy to mix into many widgets   | ❌ Code duplication likely          |

Use `ReadyLayoutMixin` for a cleaner, reusable, and declarative way to
handle **first-layout-dependent logic** in your Flutter widgets.
