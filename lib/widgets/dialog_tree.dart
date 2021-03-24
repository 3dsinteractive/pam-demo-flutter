import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogTree {
  DialogTree._();

  static DialogTreeRoute? route;

  static Future show(BuildContext context,
      Widget Function(void Function() dismiss) fWidget) async {
    route = null;
    route = DialogTreeRoute(
      settings: RouteSettings(name: "/dialog_tree"),
      widget: fWidget(() => route?.navigator?.removeRoute(route!)),
    );

    return await Navigator.of(context, rootNavigator: false).push(route!);
  }

  static void dispose() {
    return route?.dispose();
  }
}

class DialogTreeRoute extends OverlayRoute {
  final Builder _builder;

  DialogTreeRoute({
    required RouteSettings settings,
    required Widget widget,
  })   : _builder = Builder(builder: (BuildContext innerContext) {
          return widget;
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
