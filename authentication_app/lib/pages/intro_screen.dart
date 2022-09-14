import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int initialIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: IndexedStack(
            index: initialIndex,
            children: [
              indexPage("assets/images/Welcome2.jpg", "WELCOME"),
              indexPage("assets/images/application.jpg", "Application"),
              indexPage("assets/images/login.png", "Press next to login"),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          setState(() {
            if (initialIndex < 2) {
              initialIndex++;
            } else {
              Navigator.of(context).pushReplacementNamed('UserDetailPage');

              prefs.setBool("isIntroVisited", true);
            }
          });
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
        ),
        child: const Text("Next"),
      ),
    );
  }

  indexPage(String image, String text) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xff3F3D56),
            ),
          )
        ],
      ),
    );
  }
}
