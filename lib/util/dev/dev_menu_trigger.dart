// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:gateway_fence_employee/providers/dev_provider.dart';

class DevMenuTrigger extends StatelessWidget {
  const DevMenuTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Provider.of<DevProvider>(context).isDevMode) {
      return Container();
    }
    return TextButton(
      child: const Text('Dev Menu'),
      onPressed: () => <void>{Scaffold.of(context).openEndDrawer()},
    );
  }
}
