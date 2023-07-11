import 'package:cookbook/constants.dart';
import 'package:cookbook/screens/recipesscreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String id = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.popAndPushNamed(context, RecipesScreen.id);
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Center(
              child: Image(
                image: AssetImage(
                  'images/app_logo.png',
                ),
                height: 196,
                width: 196,
              ),
            ),
            Text(
              'EatFitGo',
              style: TextStyle(
                color: Color(0xFFBBDDA8),
                fontFamily: 'Rolest',
                fontSize: 63.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
