import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windo_ecom/Constants/ColorConstants.dart';

import '../utils/constants.dart';

class ReuseableText extends StatelessWidget {
  const ReuseableText({super.key, required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(
        text: "Rs: ",
        style: GoogleFonts.josefinSans(
            fontSize: 20.sp, color: logoColor2, fontWeight: FontWeight.w700),
        children: [
          TextSpan(
            text: price.toString(),
            style: GoogleFonts.josefinSans(
                fontSize: 20.sp, color: logoColor, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
