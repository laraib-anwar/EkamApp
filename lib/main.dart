import 'package:ekam/constants.dart';
import 'package:ekam/provider/doctors.dart';
import 'package:ekam/provider/package.dart';
import 'package:ekam/screens/home/homePage.dart';
import 'package:ekam/screens/profile/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DoctorsProvider>.value(
      value: DoctorsProvider(),
    ),
    ChangeNotifierProvider<ServiceOptionsProvider>.value(
      value: ServiceOptionsProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ekam App',
      theme: ThemeData(primaryColor: kPrimaryColor),
      home: const HomePage(title: 'Doctors List'),
    );
  }
}
