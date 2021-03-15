import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogTree {
  DialogTreeRoute? route;

  Future show(BuildContext context) async {
    this.route = DialogTreeRoute(
      settings: RouteSettings(name: "/dialog_tree"),
      onClick: () {
        this.route?.navigator?.removeRoute(this.route!);
      },
    );

    return await Navigator.of(context, rootNavigator: false).push(route!);
  }
}

class DialogTreeRoute extends OverlayRoute {
  final Builder _builder;
  final void Function() onClick;

  DialogTreeRoute({
    required RouteSettings settings,
    required this.onClick,
  })   : _builder = Builder(builder: (BuildContext innerContext) {
          return GestureDetector(
              child: Align(
                heightFactor: 1.0,
                child: Material(
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: onClick,
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                        child: Text("Singh alert"),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {});
        }),
        super(settings: settings);

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    final List<OverlayEntry> overlays = [];

    overlays.add(
      OverlayEntry(
          builder: (BuildContext context) {
            final Widget annotatedChild = Semantics(
              child: _builder,
              focused: false,
              container: true,
              explicitChildNodes: true,
            );
            return annotatedChild;
          },
          maintainState: false,
          opaque: false),
    );

    return overlays;
  }
}
