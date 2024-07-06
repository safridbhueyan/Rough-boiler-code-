import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(children: [
            //LOGO

            Image.asset(
              'lib/images/adds.png',
              height: 170,
            ),
            const SizedBox(
              height: 25,
            ),

            //title
            Text(
              "Bring it on !",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            //Subtitle
            SizedBox(
              height: 15,
            ),

            //title
            Text(
              "Premium quality sneakers and custom kicks",
              style: TextStyle(
                color: const Color.fromARGB(255, 99, 103, 105),
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 55,
            ),
            //statnow button
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(22)),
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  "Shope now",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
