import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class TipsText extends StatelessWidget {
  const TipsText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text('Hello World!',
                style: GoogleFonts.montserrat(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                )),
            SizedBox(
              height: 150.0,
            ),
            SizedBox(
              height: 150.0,
            ),
            Text(
              "Tips : Click '+' Button to add todo",
              style: kTipsTextStyle,
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              "Tips : Long Press on a todo to delete",
              style: kTipsTextStyle,
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              "Tips : Press check to mark as completed",
              style: kTipsTextStyle,
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              "Tips : Press 3 dot button to short the list",
              style: kTipsTextStyle,
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
