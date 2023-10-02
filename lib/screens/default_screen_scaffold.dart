// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/util/dev/dev_menu.dart';
import 'package:gateway_fence_employee/util/dev/dev_menu_trigger.dart';
import 'package:gateway_fence_employee/widgets/screen_title.dart';
import 'package:gateway_fence_employee/widgets/sidebar/sidebar.dart';

/// Scaffold with a drawer and a floating action button
class DefaultScreenScaffold extends StatefulWidget {
  const DefaultScreenScaffold({
    super.key,
    required this.children,
    required this.scaffoldKey,
    this.title,
    this.subtitle,
  });

  final List<Widget> children;
  final String? title;
  final String? subtitle;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<DefaultScreenScaffold> createState() => _DefaultScreenScaffoldState();
}

/// The state of the DefaultScreenScaffold widget
class _DefaultScreenScaffoldState extends State<DefaultScreenScaffold>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      key: widget.scaffoldKey,
      drawer: const Sidebar(),
      endDrawer: const DevMenu(),
      backgroundColor: AppColors.greyLight,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.scaffoldKey.currentState?.openDrawer();
        },
        child: const Icon(Icons.menu),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 1200,
            ),
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: ListView(
              children: <Widget>[
                if (widget.title != null)
                  ScreenTitle(
                    title: widget.title!,
                    subtitle: widget.subtitle,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    children: widget.children,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                const DevMenuTrigger(),
                // const DevMenu(), // only shows in dev mode
              ],
            ),
          ),
        ),
      ),
    );
  }
}
