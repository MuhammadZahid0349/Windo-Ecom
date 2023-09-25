import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:windo_ecom/Constants/ColorConstants.dart';

import '../data/app_data.dart';
import '../model/base_model.dart';

class AddToCart {
  static void addToCart(BaseModel data, BuildContext context) {
    bool contains = itemsOnCart.contains(data);

    if (contains == true) {
      const AdvanceSnackBar(
        textSize: 14.0,
        bgColor: Colors.red,
        message: 'You have added this item to cart before',
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 5),
      ).show(context);
    } else {
      itemsOnCart.add(data);

      const AdvanceSnackBar(
        bgColor: skyColor2,
        textSize: 14.0,
        message: 'Successfully added to your cart',
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 5),
      ).show(context);
    }
  }
}
