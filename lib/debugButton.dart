import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/providers/user_preference.dart';

/// A debug button to modify some config for dev stage
/// NOTE: do not bring it to online env
class DebugButton extends ConsumerWidget {
  final Offset offset;
  final Function(Offset) onDrag;
  final bool isVisible; // Control visibility from parent widget

  const DebugButton({
    Key? key,
    required this.offset,
    required this.onDrag,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isVisible) {
      return SizedBox.shrink(); // Return an empty widget if not visible
    }

    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          onDrag(offset + details.delta);
        },
        onTap: () => _onDebugButtonTap(context, ref),
        child: Icon(Icons.bug_report, size: 50, color: Colors.red),
      ),
    );
  }

  _onDebugButtonTap(BuildContext context, WidgetRef ref) async {
    // await userPref.deleteAllKeys();
    ref.read(preferencesProvider.future).then((userPref) {
      userPref.deleteAllKeys();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("All keys deleted!"),
        duration: Duration(
            seconds: 2), // Duration for which the snackbar will be visible
        behavior: SnackBarBehavior
            .floating, // Makes the snackbar float above other elements
      ),
    );
  }
}
