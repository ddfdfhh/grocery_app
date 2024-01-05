import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:citymall/bottom_sheets/bottom_drawer.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/bottom_cart_strip.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:citymall/widgets/button_with_icon_text.dart';
import 'package:citymall/widgets/cart_button.dart';
import 'package:citymall/widgets/category/circular_category.dart';
import 'package:citymall/widgets/expansion.dart';
import 'package:citymall/widgets/imageWidget.dart';
import 'package:citymall/widgets/item_counter_widget.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:citymall/widgets/price_widget.dart';
import 'package:citymall/widgets/price_widget_row_form.dart';
import 'package:citymall/widgets/product_slider.dart';
import 'package:citymall/widgets/vegetable_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:tab_container/tab_container.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class ProductDetailScreen extends StatelessWidget {
  int itemCount = 0;
  // ProductDetailScreen();
  CarouselController controller = CarouselController();
  CartController cartController = Get.find();
  ProductController pc = Get.put(ProductController());
  var currentPage = 1.obs;
  @override
  Widget build(BuildContext context) {
    NetworkController nc = Get.find();
    return Obx(() => nc.hasConnection.value
        ? Scaffold(
            bottomNavigationBar: BottomCartStrip(),
            appBar: AppBar(
                title: Obx(() => Text(pc.isLoading.value
                    ? 'Loading Detail..'
                    : pc.productLocal.value!.name!))),
            backgroundColor: Colors.white,
            body: Obx(() => pc.productId.value > 0 &&
                    pc.productLocal != null &&
                    !pc.isLoading.value
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 10),
                            child: SizedBox(
                                height: 200,
                                child: Stack(
                                  children: [
                                    if (pc.productLocal.value?.images != null &&
                                        pc.productLocal.value!.images!
                                            .isNotEmpty)
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: 30,
                                                child: DotIndicator(false)),
                                            Expanded(
                                                child: CarouselSlider(
                                                    carouselController:
                                                        controller,
                                                    options: CarouselOptions(
                                                      viewportFraction: 1,
                                                    ),
                                                    items: pc.productLocal
                                                        .value!.images!
                                                        .map((i) {
                                                      return Builder(
                                                        builder: (BuildContext
                                                            context) {
                                                          return Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                            fit: BoxFit.contain,
                                                            image: NetworkImage(
                                                                '$baseUrl/storage/products/${pc.productLocal.value?.id!}/'
                                                                'thumbnail/${i.thumbnail?.large}'),
                                                          )));
                                                        },
                                                      );
                                                    }).toList())),
                                            SizedBox(
                                                width: 30,
                                                child: DotIndicator(true))
                                          ])
                                    else
                                      SizedBox(
                                          height: 220,
                                          width: double.infinity,
                                          child: Center(
                                              child: CachedImageWidget(
                                                  context,
                                                  '$baseUrl/storage/products/${pc.productLocal.value?.id!}/'
                                                  '${pc.productLocal.value?.image}',
                                                  null,
                                                  null,
                                                  null))),
                                    if (pc.selected_product_discount_text
                                                .value !=
                                            null &&
                                        pc.selected_product_discount_text.value
                                            .isNotEmpty)
                                      Positioned(
                                          top: 0,
                                          left: 1,
                                          child: Container(
                                              height: 23,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppTheme(context: context)
                                                          .colors['secondary'],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(50),
                                                  )),
                                              child: Center(
                                                  child: AutoSizeText(
                                                      '${pc.selected_product_discount_text} OFF',
                                                      style: AppTheme(
                                                                  context: context)
                                                              .textTheme[
                                                          'bodySmallWhite']))))
                                  ],
                                ))),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${toBeginningOfSentenceCase(pc.productLocal.value?.name)}",
                                      style: AppTheme(context: context)
                                          .textTheme['titleLargeBold'],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: CartButton(
                                          qtyUpdateCallback: (mode, qty) {
                                            print('here');
                                            pc.addCartSigleProductPage(
                                                qty, mode);
                                          },
                                          maxQtyAllowed: pc.productLocal.value!
                                                  .maxQuantityAllowed ??
                                              10,
                                          initialQty: cartController
                                              .checkProductQtyInCart(
                                                  pc.productId.value, null),
                                          disabled: pc.productLocal.value!
                                                      .hasVariant ==
                                                  'Yes' &&
                                              pc.selectedVariantId.value == 0)),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (pc.productLocal.value!.perQuantityOf! >
                                          0 &&
                                      pc.productLocal.value!.perUnit!
                                          .isNotEmpty &&
                                      pc.productLocal.value!.perPrice! > 0)
                                    Expanded(
                                      flex: 2,
                                      child: AutoSizeText(
                                          "(₹${pc.productLocal.value!.perPrice ?? '0.00'!}/${pc.productLocal.value!.perQuantityOf!}${pc.productLocal.value!.perUnit!})",
                                          textAlign: TextAlign.start,
                                          style: AppTheme(context: context)
                                                  .textTheme[
                                              'titleSmallBoldOrange']),
                                    ),
                                  Expanded(
                                      child: SizedBox(
                                    width: 120,
                                    child: PriceWithSalePriceRowForm(
                                        context,
                                        pc.productLocal.value!.price!,
                                        pc.productLocal.value!.salePrice,
                                        align: MainAxisAlignment.start),
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              AutoSizeText(
                                "${pc.productLocal.value!.shortDescription ?? ''}",
                                style: TextStyle(
                                    color: Color(0xff979899),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        if (pc.productLocal.value?.variants != null &&
                            pc.productLocal.value!.variants!.isNotEmpty)
                          VariantShow(context, pc.productLocal.value!,
                              pc.productLocal!.value!.variants!),
                        SizedBox(height: 20),
                        Tabs1(context, pc.productLocal.value!),
                        SizedBox(height: 10),
                        if (pc.related_products.value.length > 0) ...[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Related Products',
                                textAlign: TextAlign.start,
                                style: AppTheme(context: context)
                                    .textTheme['titleLargeBold']),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                    pc.related_products.value.length, (index) {
                                  Product item =
                                      pc.related_products.value[index];
                                  return SizedBox(
                                    width: 200,
                                    child: VegetableCardWidget(
                                        context: context,
                                        item: item,
                                        onVariantTapCallback: (Product item) {
                                          pc.selectedProduct(item);
                                          BottomDrawer(context, item);
                                        },
                                        onTapCallback: () {}),
                                  );
                                })),
                          )
                        ]
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator())),
          )
        : NoInternet(context));
  }

  Widget VariantShow(
      BuildContext context, Product pro, List<Variants> variants) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List<Widget>.generate(variants.length, (index) {
        return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black12, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            title: Text('${toUpperCase(variants[index].name)}'),
            leading: Radio(
              activeColor: AppTheme(context: context).colors['primary'],
              value: variants[index].id,
              groupValue: pc.selectedVariantId.value,
              onChanged: (value) {
                if (variants[index].quantity! > 0) {
                  pc.selectedVariantId.value = value!;
                  pc.selectedVariant.value = variants[index];
                  pc.selectedProduct.value = pro;
                }
              },
            ),
            trailing: SizedBox(
              height: 80,
              width: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PriceWithSalePriceRowForm(
                      context,
                      variants[index].price ?? pro.price!,
                      variants[index].salePrice ?? pro.salePrice),
                  if (variants[index].quantity! < 1)
                    Text('Out of Stock', style: TextStyle(color: Colors.red))
                ],
              ),
            ));
      }),
    );
  }

  Widget Tabs1(BuildContext context, Product item) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: TabBar(
                overlayColor:
                    MaterialStateProperty.all(Colors.lightGreen.shade100),
                dividerColor: AppTheme(context: context).colors['primary'],
                labelColor: AppTheme(context: context).colors['primary'],
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.black87,
                unselectedLabelStyle: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                indicatorColor: AppTheme(context: context).colors['primary'],
                indicator: BoxDecoration(
                    color: Colors.lightGreen.shade50,
                    border: Border(
                      bottom: BorderSide(
                        //                   <--- left side
                        color: AppTheme(context: context).colors['primary'],
                        width: 2.0,
                      ),
                    )),
                tabs: [
                  Tab(text: "Description"),
                  Tab(text: "Features"),
                  Tab(text: "Specification"),
                ]),
          ),
          AutoScaleTabBarView(children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Html(
                  data: '${item.description ?? ''}',
                )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Html(
                  data: '${item.features ?? ''}',
                )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Html(
                  data: '${item.specifications ?? ''}',
                )),
          ]),
        ],
      ),
    );
  }

  Widget DotIndicator(bool isNext) {
    return InkWell(
        onTap: () {
          if (isNext)
            controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
          else
            controller.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
        },
        child: Container(
            height: 50,
            width: 50,
            color: Colors.lightGreen.shade100,
            child: Center(
                child: !isNext
                    ? Icon(Icons.arrow_left_outlined, color: Colors.green)
                    : Icon(Icons.arrow_right_outlined, color: Colors.green))));
  }
}
