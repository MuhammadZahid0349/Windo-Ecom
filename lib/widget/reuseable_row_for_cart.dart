import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'reuseable_text.dart';

class ReuseableRowForCart extends StatelessWidget {
  const ReuseableRowForCart({
    Key? key,
    required this.text,
    required this.price,
  }) : super(key: key);

  final double price;
  final String text;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.josefinSans(
                fontSize: 16.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w700),
          ),
          ReuseableText(
            price: price,
          )
        ],
      ),
    );
  }
}
