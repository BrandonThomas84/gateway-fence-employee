import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/widgets/sidebar/sidebar.dart';


/// Scaffold with a drawer and a floating action button
class DefaultScreenScaffold extends StatefulWidget {
  final List<Widget> children;
  final String? title;
  final GlobalKey<ScaffoldState> scaffoldKey;


  const DefaultScreenScaffold({
    super.key,
    required this.children,
    required this.scaffoldKey,
    this.title,
  });

  @override
  State<DefaultScreenScaffold> createState() => _DefaultScreenScaffoldState();
}

/// The state of the DefaultScreenScaffold widget
class _DefaultScreenScaffoldState extends State<DefaultScreenScaffold>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.greyLight,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
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
