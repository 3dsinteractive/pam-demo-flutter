import 'package:flutter/material.dart';
import 'package:pam_flutter/pam_flutter.dart';
import 'package:singh_architecture/pages/launch_screen.dart';
import 'package:singh_architecture/pams/pages/consent_page.dart';
import 'package:singh_architecture/repositories/page_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Pam.initial(enableLog: true).then((_) {
    runApp(
      MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConsentPage(),
      // home: LaunchScreen(
      //   launchScreenRepository: PageRepository(),
      // ),
    );
  }
}
