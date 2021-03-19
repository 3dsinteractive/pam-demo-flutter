import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/widgets/commons/loading_stack.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountPageState();
  }
}

class AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [],
        children: () => [

        ],
      ),
    );
  }
}
