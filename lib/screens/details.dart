import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:windo_ecom/Constants/ColorConstants.dart';

import '../model/base_model.dart';
import '../utils/constants.dart';
import '../widget/add_to_cart.dart';
import '../widget/reuseable_text.dart';
import '../widget/reuseable_button.dart';

class Details extends StatefulWidget {
  const Details({
    required this.data,
    super.key,
    required this.isCameFromMostPopularPart,
  });

  final BaseModel data;
  final bool isCameFromMostPopularPart;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selectedSize = 3;
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    BaseModel current = widget.data;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Top Image
              SizedBox(
                width: size.width,
                height: size.height * 0.5,
                child: Stack(
                  children: [
                    Hero(
                      tag: widget.isCameFromMostPopularPart
                          ? current.imageUrl
                          : current.id,
                      child: Container(
                        width: size.width,
                        height: size.height * 0.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(current.imageUrl),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: size.width,
                        height: size.height * 0.12,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: gradient),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// info
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              current.name,
                              style: GoogleFonts.josefinSans(
                                  fontSize: 20.sp,
                                  color: logoColor2,
                                  fontWeight: FontWeight.w700),
                            ),
                            ReuseableText(
                              price: current.price,
                            )
                          ],
                        ),
                        6.h.heightBox,
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 25.sp,
                            ),
                            5.w.widthBox,
                            Text(
                              current.star.toString(),
                              style: GoogleFonts.josefinSans(
                                  fontSize: 25.sp,
                                  color: logoColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            8.w.widthBox,
                            Text(
                              "(${current.review.toString()}K+ review)",
                              style: GoogleFonts.josefinSans(
                                  fontSize: 20.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700),
                            ),
                            5.w.widthBox,
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey,
                              size: 20.sp,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              /// Select size
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 15.0, bottom: 3.0),
                  child: Text(
                    "Select Size",
                    style: GoogleFonts.josefinSans(
                        fontSize: 25.sp,
                        color: logoColor2,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              ///Sizes
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: SizedBox(
                  // color: Colors.red,
                  width: size.width * 0.9,
                  height: size.height * 0.08,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: sizes.length,
                      itemBuilder: (ctx, index) {
                        var current = sizes[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AnimatedContainer(
                              width: size.width * 0.12,
                              decoration: BoxDecoration(
                                color: selectedSize == index
                                    ? skyColor1
                                    : Colors.transparent,
                                border: Border.all(color: skyColor2, width: 2),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              duration: const Duration(milliseconds: 200),
                              child: Center(
                                child: Text(
                                  current,
                                  style: GoogleFonts.josefinSans(
                                      fontSize: 15.sp,
                                      color: selectedSize == index
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),

              /// Select Color
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 4.0, bottom: 3.0),
                  child: Text(
                    "Select Color",
                    style: GoogleFonts.josefinSans(
                        fontSize: 25.sp,
                        color: logoColor2,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              ///Colors
              FadeInUp(
                delay: const Duration(milliseconds: 700),
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.05,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: colors.length,
                      itemBuilder: (ctx, index) {
                        var current = colors[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: AnimatedContainer(
                              width: size.width * 0.12,
                              decoration: BoxDecoration(
                                color: current,
                                border: Border.all(
                                    color: selectedColor == index
                                        ? logoColor2
                                        : Colors.transparent,
                                    width: selectedColor == index ? 2 : 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              duration: const Duration(milliseconds: 200),
                            ),
                          ),
                        );
                      }),
                ),
              ),

              /// Add To Cart Button
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.03),
                  child: ReuseableButton(
                    text: "Add to cart",
                    onTap: () {
                      AddToCart.addToCart(current, context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
        ),
      ],
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
