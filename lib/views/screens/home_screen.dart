import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            //Heading text
            Text("EZ TICKETS", style: textTheme.headline1),

            //Welcome msg
            Text(
              "Welcome to the new nueplex cinemas app",
              style: textTheme.headline4,
            ),

            //experience msg

            //Row
              //login button
              //face id button

            //register button
          ],
        ),
      ),
    );
  }
}
