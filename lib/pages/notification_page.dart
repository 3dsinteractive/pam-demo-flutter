import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/common/loading_stack.dart';
import 'package:singh_architecture/widgets/common/top_bar.dart';

class NotificationsPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  NotificationsPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return NotificationsPageState();
  }
}

class NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();

    widget.context.repositories().notificationRepository().fetch(isMock: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [
          widget.context.repositories().notificationRepository().isLoadingSC
        ],
        children: () => [
          Container(
            padding: EdgeInsets.only(
              top: 85 + MediaQuery.of(context).padding.top + 8,
              left: 8,
              right: 8,
            ),
            child: ListView(
              padding: EdgeInsets.only(
                top: 8,
              ),
              children: List.generate(
                  widget.context
                          .repositories()
                          .notificationRepository()
                          .items
                          ?.length ??
                      0, (index) {
                return Container(
                  height: 108,
                  margin: EdgeInsets.only(
                    bottom: 8,
                  ),
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                child: Icon(
                                  Icons.notifications_none,
                                  size: h4,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        bottom: 8,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.context
                                            .repositories()
                                            .notificationRepository()
                                            .items![index]
                                            .Title,
                                        style: TextStyle(
                                          height: 1,
                                          fontSize: p,
                                          fontWeight: fontWeightBold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        widget.context
                                            .repositories()
                                            .notificationRepository()
                                            .items![index]
                                            .Message,
                                        style: TextStyle(
                                          color: colorGray,
                                          fontSize: s2,
                                          fontWeight: fontWeightBold,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 8,
                        ),
                        alignment: Alignment.centerRight,
                        child: Text(
                          widget.context
                              .repositories()
                              .notificationRepository()
                              .items![index]
                              .CreatedDate,
                          style: TextStyle(
                            color: colorGrayDark,
                            fontSize: s2,
                            fontWeight: fontWeightBold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          TopBar(
            title: "Notification",
          ),
        ],
      ),
    );
  }
}
