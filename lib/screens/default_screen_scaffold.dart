import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
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
            child: ListView(
              children: [
                if (widget.title != null)
                  ScreenTitle(title: widget.title!, subtitle: widget.subtitle,),
                ...widget.children,
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
