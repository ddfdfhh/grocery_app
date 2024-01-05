import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/models/user_model.dart';
import 'package:citymall/widgets/vegetable_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

List<String> products = [
  "One",
  "Second",
  "One",
  "Second",
  "One",
  "Second",
  "One",
  "Second"
];
Widget BestSelling() {
  // print(this.cartController?.cart_count.value);

  return LayoutBuilder(builder: (context, constraints) {
    CartController cartController = Get.find();
    return GridView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) =>
      //     VegetableCardWidget(
      //   item: new Product("sdfdf","2323"),
      //
      //   onTapCallback: () {
      //     //   Navigator.pushNamed(
      //     //       context, MyRoutes.vegetableDetailRoute);
      //   },
      //   qtyUpdateCallback: (mode, qty) async {
      //     print(qty);
      //     print(mode);
      //     if (mode == 'plus')
      //       cartController.cart_count.value++;
      //     else
      //       cartController?.cart_count.value--;
      //     final userBox = await Hive.openBox(USER_CACHE_BOX);
      //     final UserModel cacheUser = userBox.get('user') as UserModel;
      //     print("my name is ");
      //     print(cacheUser.name);
      //   },
      // )
      //
      const Text('okoko'),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: constraints.maxWidth > 700 ? 4 : 2, //<-SEE HERE
        childAspectRatio: .7,
      ),
    );
  });
}
