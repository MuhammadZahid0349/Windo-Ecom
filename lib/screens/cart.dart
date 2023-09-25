import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:windo_ecom/Constants/ColorConstants.dart';

import '../data/app_data.dart';
import '../widget/reuseable_row_for_cart.dart';
import '../main_wrapper.dart';
import '../model/base_model.dart';
import '../utils/constants.dart';
import '../widget/reuseable_button.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}
//CodeWithFlexz on Instagram

//AmirBayat0 on Github
//Programming with Flexz on Youtube

class _CartState extends State<Cart> {
  /// Calculate the Total Price
  double calculateTotalPrice() {
    double total = 0.0;
    if (itemsOnCart.isEmpty) {
      total = 0;
    } else {
      for (BaseModel data in itemsOnCart) {
        total = total + data.price * data.value;
      }
    }
    return total;
  }

  /// Calculate Shipping
  double calculateShipping() {
    double shipping = 0.0;
    if (itemsOnCart.isEmpty) {
      shipping = 0.0;
      return shipping;
    } else if (itemsOnCart.length <= 4) {
      shipping = 25.99;
      return shipping;
    } else {
      shipping = 88.99;
      return shipping;
    }
  }

  /// Calculate the Sub Total Price
  int calculateSubTotalPrice() {
    int subTotal = 0;
    if (itemsOnCart.isEmpty) {
      subTotal = 0;
    } else {
      for (BaseModel data in itemsOnCart) {
        subTotal = subTotal + data.price.round();
        subTotal = subTotal - 160;
      }
    }
    return subTotal < 0 ? 0 : subTotal;
  }

  /// delete function for cart
  void onDelete(BaseModel data) {
    setState(() {
      if (itemsOnCart.length == 1) {
        itemsOnCart.clear();
      } else {
        itemsOnCart.removeWhere((element) => element.id == data.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SizedBox(
              width: Get.width,
              height: 320.h,
              child: itemsOnCart.isEmpty

                  /// List is Empty:
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          FadeInUp(
                            delay: const Duration(milliseconds: 200),
                            child: const Image(
                              image: AssetImage("assets/images/empty.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          10.h.heightBox,
                          FadeInUp(
                            delay: const Duration(milliseconds: 250),
                            child: Text(
                              "Your cart is empty right now :(",
                              style: GoogleFonts.josefinSans(
                                  fontSize: 18.sp,
                                  color: logoColor2,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          FadeInUp(
                            delay: const Duration(milliseconds: 300),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainWrapper()));
                              },
                              icon: Icon(
                                Icons.shopping_bag_outlined,
                                color: skyColor2,
                                size: 30.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                  /// List is Not Empty:
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: itemsOnCart.length,
                      itemBuilder: (context, index) {
                        var current = itemsOnCart[index];
                        return FadeInUp(
                          delay: Duration(milliseconds: 100 * index + 80),
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            width: Get.width,
                            height: 200.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: Color.fromARGB(61, 0, 0, 0),
                                      )
                                    ],
                                    color: Colors.pink,
                                    image: DecorationImage(
                                        image: AssetImage(current.imageUrl),
                                        fit: BoxFit.cover),
                                  ),
                                  width: size.width * 0.4,
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.52,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              current.name,
                                              softWrap: true,
                                              style: GoogleFonts.josefinSans(
                                                  fontSize: 14.sp,
                                                  color: logoColor2,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  onDelete(current);
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.grey,
                                                ))
                                          ],
                                        ),
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              text: "Rs: ",
                                              style: GoogleFonts.josefinSans(
                                                  fontSize: 14.sp,
                                                  color: logoColor,
                                                  fontWeight: FontWeight.w700),
                                              children: [
                                            TextSpan(
                                              text: current.price.toString(),
                                              style: GoogleFonts.josefinSans(
                                                  fontSize: 14.sp,
                                                  color: logoColor2,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          ])),
                                      SizedBox(
                                        height: size.height * 0.04,
                                      ),
                                      Text(
                                        "Size = ${sizes[3]}",
                                        style: GoogleFonts.josefinSans(
                                            fontSize: 14.sp,
                                            color: logoColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: size.height * 0.058,
                                        ),
                                        width: size.width * 0.4,
                                        height: size.height * 0.04,
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(4.0),
                                              width: size.width * 0.065,
                                              height: size.height * 0.045,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onTap: () {
                                                  setState(() {
                                                    if (current.value > 1) {
                                                      current.value--;
                                                    } else {
                                                      onDelete(current);
                                                      current.value = 1;
                                                    }
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.02),
                                              child: Text(
                                                current.value.toString(),
                                                style: textTheme.subtitle2
                                                    ?.copyWith(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(4.0),
                                              width: size.width * 0.065,
                                              height: size.height * 0.045,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onTap: () {
                                                  setState(() {
                                                    current.value >= 0
                                                        ? current.value++
                                                        : null;
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
            ),

            /// Bottom Card
            Positioned(
              bottom: 0,
              child: Container(
                width: Get.width,
                height: 270.h,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FadeInUp(
                          delay: const Duration(milliseconds: 350),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Promo/Student Code or Vourchers",
                                style: GoogleFonts.josefinSans(
                                    fontSize: 15.sp,
                                    color: logoColor,
                                    fontWeight: FontWeight.w800),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: logoColor2,
                                size: 22.sp,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: ReuseableRowForCart(
                            price: calculateSubTotalPrice().toDouble(),
                            text: 'Sub Total',
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 450),
                          child: ReuseableRowForCart(
                            price: calculateShipping(),
                            text: 'Shipping',
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Divider(),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          child: ReuseableRowForCart(
                            price: calculateTotalPrice(),
                            text: 'Total',
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 550),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: ReuseableButton(
                                text: "Checkout",
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Cart()));
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "My Cart",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            LineIcons.user,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
