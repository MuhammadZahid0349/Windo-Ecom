import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'ColorConstants.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 3)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 40.0
    ..radius = 15.0
    ..progressColor = MColor.withOpacity(0.5)
    ..backgroundColor = MColor.withOpacity(0.7)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..textStyle = const TextStyle(fontSize: 22, fontStyle: FontStyle.italic)
    ..maskColor = Colors.grey.withOpacity(0.7)
    ..userInteractions = true
    ..maskType = EasyLoadingMaskType.custom
    ..dismissOnTap = false;
}

GestureDetector BackBtn(Color iconcolor) {
  return GestureDetector(
    onTap: () {
      Get.back();
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 6.w),
      height: 36.h,
      width: 36.w,
      decoration: BoxDecoration(
        color: kSecColor.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: Icon(
        Icons.arrow_back_ios,
        color: iconcolor,
        size: 25.sp,
      ),
    ),
  );
}

CustomizedSnackBar(var title, var message) {
  Get.snackbar("$title", "$message",
      colorText: MColor,
      borderRadius: 20.r,
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      animationDuration: const Duration(milliseconds: 500),
      // backgroundGradient: const LinearGradient(colors: [Colors.white, white]),
      borderWidth: 4,
      forwardAnimationCurve: Curves.bounceInOut,
      backgroundColor: Colors.white.withOpacity(0.8),
      duration: const Duration(milliseconds: 3000), // visible Time
      icon: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Image.asset(
          "assets/a.png",
        ),
      ));
}

////////// Text /////////////////////
Widget CustomizedText(
    {text,
    size,
    FontWeight,
    color,
    textalign,
    double? btwSpace,
    double? height}) {
  return Text(text,
      softWrap: true,
      textAlign: textalign ?? TextAlign.center,
      style: GoogleFonts.josefinSans(
          color: color ?? MColor,
          fontWeight: FontWeight,
          fontSize: size,
          height: height ?? 1,
          letterSpacing: btwSpace ?? 1));
}

Container CustomziedButton({text, onFunction}) {
  return Container(
    height: 46.h,
    width: 295.w,
    child: ElevatedButton(
        onPressed: onFunction,
        style: ElevatedButton.styleFrom(
          backgroundColor: MColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        child: CustomizedText(
            text: text,
            size: 16.sp,
            FontWeight: FontWeight.w700,
            color: Colors.white,
            btwSpace: 7)),
  );
}

String formatTime(DateTime dateTime) {
  return DateFormat.jm().format(dateTime); // Format time as 2:30 PM
}

String formatDate(DateTime dateTime) {
  return DateFormat('dd-MMM-yyyy')
      .format(dateTime); // Format date as 17-Aug-2023
}

createRichText(String heading, String definition) {
  return RichText(
    textAlign: TextAlign.justify,
    text: TextSpan(
      text: heading,
      style: TextStyle(
        color: logoColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      children: <TextSpan>[
        TextSpan(
          text: definition,
          style: TextStyle(
            color: Colors.black,
            fontSize: 13.sp,
          ),
        ),
      ],
    ),
  );
}
