import 'package:flutter/material.dart';
import 'Services.dart';
import 'onboarding/onboarding_1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Annoying Friend',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            //primarySwatch: Colors.blue,
            primaryColor: Colors.black87),
        debugShowCheckedModeBanner: false,
        home: OnboardingPage(pages: [
          //#1
          OnboardingPageModel(
            title: "Hello",
            description: "Welcome to Annoying Friend App",
            image: 'assets/img/sketch-1679189034408-removebg-preview.png',
            bgColor: Colors.white,
          ),

          //#2
          OnboardingPageModel(
              title: "What is it about?",
              description:
                  "This App is designed to send you random notifications on random days with random content to either annoy,cheer or make you smile.",
              image: 'assets/img/sketch-1679189034408-removebg-preview.png',
              bgColor: Colors.white),
          //#3
          OnboardingPageModel(
              title: "Why?",
              description:
                  "Well because we all need that 'One' annoying friend.",
              image: 'assets/img/sketch-1679189034408-removebg-preview.png',
              bgColor: Colors.white),
        ]));
  }
}
