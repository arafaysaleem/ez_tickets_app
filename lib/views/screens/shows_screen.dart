import 'package:flutter/material.dart';

import '../../helper/utils/constants.dart';
import '../widgets/common/custom_text_button.dart';

List<String> showDates = ["14\nSun", "15\nMon", "16\nTue", "17\nWed"];
List<String> showTimes = ["3:30", "4:30", "5:30", "6:30"];

class ShowsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Constants.scaffoldGreyColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(
          20,
          125,
          20,
          Constants.bottomInsets,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            //Dates list
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: showDates.length,
                separatorBuilder: (ctx,i) => const SizedBox(width: 10),
                itemBuilder: (ctx,i) => Container(
                  width: 60,
                  decoration: BoxDecoration(
                    gradient: Constants.buttonGradientOrange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      showDates[i],
                      textAlign: TextAlign.center,
                      style: textTheme.headline3!.copyWith(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50),

            //Show times list
            SizedBox(
              height: 45,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: showTimes.length,
                separatorBuilder: (ctx,i) => const SizedBox(width: 10),
                itemBuilder: (ctx,i) => Container(
                  width: 110,
                  decoration: BoxDecoration(
                      gradient: Constants.buttonGradientOrange,
                      borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      showTimes[i],
                      style: textTheme.headline3!.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),

            //Continue button
            CustomTextButton.gradient(
              width: double.infinity,
              onPressed: (){},
              gradient: Constants.buttonGradientOrange,
              child: const Center(
                child: const Text(
                  "CONTINUE",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
