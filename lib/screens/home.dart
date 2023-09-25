import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:windo_ecom/Constants/ColorConstants.dart';
import 'package:windo_ecom/Constants/utils.dart';
import 'package:windo_ecom/widget/slider/slider_screen.dart';

import '../data/app_data.dart';
import '../screens/details.dart';
import '../model/categories_model.dart';
import '../utils/constants.dart';
import '../model/base_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;
  final int _currentIndex = 2;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: _currentIndex, viewportFraction: 0.7);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Heading
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Find your",
                          style: GoogleFonts.josefinSans(
                              fontSize: 20.sp, color: logoColor),
                          children: [
                            TextSpan(
                              text: " Style :_:",
                              style: GoogleFonts.josefinSans(
                                  fontSize: 20.sp,
                                  color: logoColor2,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Be more beautiful with our ",
                          style: GoogleFonts.josefinSans(
                              fontSize: 15.sp,
                              color: logoColor,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: "suggestions :)",
                              style: GoogleFonts.josefinSans(
                                  fontSize: 15.sp,
                                  color: logoColor2,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      10.h.heightBox,
                    ],
                  ),
                ),
              ),

              ///  Slider
              FadeInUp(child: const SliderScreen()),
              7.h.heightBox,

              /// Categories
              FadeInUp(
                delay: const Duration(milliseconds: 450),
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: Get.width,
                  // color: Colors.red,
                  height: 95.h,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (ctx, index) {
                        CategoriesModel current = categories[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.h),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage(current.imageUrl),
                              ),
                              8.h.heightBox,
                              CustomizedText(
                                  text: current.title,
                                  color: logoColor2,
                                  size: 14.sp)
                            ],
                          ),
                        );
                      }),
                ),
              ),

              /// Body Slider
              FadeInUp(
                delay: const Duration(milliseconds: 550),
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: Get.width,
                  height: 310.h,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: mainList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details(
                                  data: mainList[index],
                                  isCameFromMostPopularPart: false,
                                ),
                              ),
                            );
                          },
                          child: view(index, textTheme, size));
                    },
                  ),
                ),
              ),
              const Divider(),

              /// Most Popular Text
              FadeInUp(
                delay: const Duration(milliseconds: 650),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Most Popular",
                        style: GoogleFonts.josefinSans(
                            fontSize: 20.sp,
                            color: logoColor2,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "See all",
                        style: GoogleFonts.josefinSans(
                            fontSize: 20.sp,
                            color: logoColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),

              /// Most Popular Content
              FadeInUp(
                delay: const Duration(milliseconds: 750),
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  width: Get.width,
                  height: 490.h,
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: mainList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.63),
                      itemBuilder: (context, index) {
                        BaseModel current = mainList[index];
                        return GestureDetector(
                          onTap: (() => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  return Details(
                                    data: current,
                                    isCameFromMostPopularPart: true,
                                  );
                                }),
                              )),
                          child: Hero(
                            tag: current.imageUrl,
                            child: Column(
                              children: [
                                Container(
                                  width: 160.w,
                                  height: 210.h,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    image: DecorationImage(
                                      image: AssetImage(current.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: Color.fromARGB(61, 0, 0, 0),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    current.name,
                                    style: GoogleFonts.josefinSans(
                                        fontSize: 18.sp,
                                        color: logoColor,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: "Rs: ",
                                        style: GoogleFonts.josefinSans(
                                            fontSize: 15.sp,
                                            color: logoColor2,
                                            fontWeight: FontWeight.w800),
                                        children: [
                                      TextSpan(
                                        text: current.price.toString(),
                                        style: GoogleFonts.josefinSans(
                                            fontSize: 15.sp,
                                            color: logoColor,
                                            fontWeight: FontWeight.w800),
                                      )
                                    ])),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Page View
  Widget view(int index, TextTheme theme, Size size) {
    return AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double value = 0.0;
          if (_pageController.position.haveDimensions) {
            value = index.toDouble() - (_pageController.page ?? 0);
            value = (value * 0.04).clamp(-1, 1);
          }
          return Transform.rotate(
            angle: 3.14 * value,
            child: card(mainList[index], theme, size),
          );
        });
  }

  /// Page view Cards
  Widget card(BaseModel data, TextTheme theme, Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Hero(
            tag: data.id,
            child: Container(
              width: size.width * 0.6,
              height: size.height * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                image: DecorationImage(
                  image: AssetImage(data.imageUrl),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Color.fromARGB(61, 0, 0, 0))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              data.name,
              style: GoogleFonts.josefinSans(
                  fontSize: 20.sp,
                  color: logoColor2,
                  fontWeight: FontWeight.w600),
            ),
          ),
          2.h.heightBox,
          RichText(
            text: TextSpan(
              text: "Rs:",
              style: GoogleFonts.josefinSans(
                  fontSize: 18.sp,
                  color: logoColor,
                  fontWeight: FontWeight.w800),
              children: [
                TextSpan(
                  text: data.price.toString(),
                  style: GoogleFonts.josefinSans(
                      fontSize: 18.sp,
                      color: logoColor2,
                      fontWeight: FontWeight.w800),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
