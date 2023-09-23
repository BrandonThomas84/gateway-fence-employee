import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/providers/dev_provider.dart';
import 'package:provider/provider.dart';

import 'dev_menu_item.dart';

class DevMenu extends StatelessWidget {
  const DevMenu({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Provider.of<DevProvider>(context).isDevMode) {
      return Container();
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DevMenuItem(
                  buttonText: 'Test Menu',
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Funck Spunk Monkey Junky'),
                          content: const SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text(
                                    'I fucking dare you to click approve you piece of shit!'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Approve'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
