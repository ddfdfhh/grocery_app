import 'package:citymall/constants.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterScreen extends StatelessWidget {
  ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
        child: DefaultTabController(
      length: 2,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        TabBar(
          indicatorColor: AppTheme(context: context).colors['primary'],
          labelColor: AppTheme(context: context)
              .colors['primary'], //<-- selected text color
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(
              text: "Filter",
            ),
            Tab(text: "Sort")
          ],
        ),
        Expanded(
            child: TabBarView(children: [
          FilterView(context),
          SortView(context),
        ])),
        ElevatedButton(
            onPressed: () {
              Get.back();
              // productController.isLoading.value=true;
              productController.applyFilter();
            },
            child: const Text("Apply Filter",
                style: TextStyle(color: Colors.white))),
        SizedBox(height: 20) // TabBarView
      ]), // Scaffold
    ));
  }

  Widget SortView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              getLabel('By Price'),
              SizedBox(height: 5),
              ListTile(
                title: const Text('Increasing Order'),
                leading: Radio<String>(
                  activeColor: AppTheme(context: context).colors['primary'],
                  value: 'ASC',
                  groupValue: productController.priceOrder.value,
                  onChanged: (String? value) {
                    productController.priceOrder.value = value!;
                  },
                ),
              ),
              ListTile(
                title: const Text('Decreasing Order'),
                leading: Radio<String>(
                  activeColor: AppTheme(context: context).colors['primary'],
                  value: 'DESC',
                  groupValue: productController.priceOrder.value,
                  onChanged: (String? value) {
                    productController.priceOrder.value = value!;
                  },
                ),
              ),
            ]),
          )),
    );
  }

  Widget FilterView(BuildContext context) {
    int price1 = productController.minPrice.toInt();
    int price2 = productController.maxPrice.toInt();
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    getLabel('Filter Brand'),
                    SizedBox(width: 15),
                    Expanded(
                        child: SearchInput(
                            context, "Brands", productController)),
                  ],
                ),
                SizedBox(height: 12),
                if (productController.brands.isNotEmpty)
                 Expanded(flex:2,
                    child: Container(
                       // height: 100,
                        child: Wrap(
                                  spacing:5,runSpacing:5,
                            children: List<Widget>.generate(
                                productController.brands.length, (int index) {
                              return FilterChip(
                                selectedColor: Colors.lightGreen,

                                label: Text('${productController.brands[index]}'),
                                labelStyle: TextStyle(color: Colors.black),
                                backgroundColor: Colors.blueGrey.shade100,
                                selected: productController.selectedBrands.value.contains(productController.brands[index]),
                                onSelected: (bool value)
                                {
                                  String br=productController.brands[index];
                                  if(value)
                                    productController.selectedBrands.add(br);
                                  else
                                    productController.selectedBrands.remove(br);
                                },
                              )
                              ;
                            }))),
                  ),
                  Divider(),
                Expanded(flex:1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getLabel('Filter Price Range'),
                      SizedBox(height: 2),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Min-${price1.toString()}"),
                            Text("Max-${price2.toString()}")
                          ]),
                      RangeSlider(
                          labels: RangeLabels(
                              productController.currentMinPrice.value
                                  .toString(),
                              productController.currentMaxPrice.value
                                  .toString()),
                          min: productController.minPrice.toDouble(),
                          max: productController.maxPrice.toDouble(),
                          onChanged: (value) {
                            int start = value.start.round();
                            int end = value.end.round();
                            productController.currentMinPrice.value = start;
                            productController.currentMaxPrice.value = end;
                            if (start != productController.minPrice.round() ||
                                end != productController.maxPrice.round()) {
                              productController.isSliderPriceChanged.value =
                                  true;
                            } else {
                              productController.isSliderPriceChanged.value =
                                  false;
                            }
                          },
                          values: RangeValues(
                              double.parse(productController
                                  .currentMinPrice.value
                                  .toString()),
                              double.parse(productController
                                  .currentMaxPrice.value
                                  .toString()))),
                    ],
                  ),
                ),
              ]),
        ));
  }

  Widget getLabel(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget OptionItem(BuildContext context, String text, String type) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            getCheckBox(context, text),
            SizedBox(
              width: 12,
            ),
            getLabelWidget(context, text),
          ],
        ),
      ),
    );
  }

  Widget getTextWidget(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget getLabelWidget(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }

  Widget getCheckBox(BuildContext context, String value) {
    return SizedBox(
      width: 25,
      height: 25,
      child: Container(
        decoration: new BoxDecoration(
            border: Border.all(width: 1.5, color: Color(0xffB1B1B1)),
            borderRadius: new BorderRadius.circular(8),
            color: Colors.transparent),
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: Colors.transparent,
          ),
          child: Checkbox(
            value: productController.selectedBrands.value.contains(value),
            onChanged: (v) {
              if (v != null && v)
                productController.selectedBrands.add(value);
              else
                productController.selectedBrands.remove(value);
              print(productController.selectedBrands);
            },
            activeColor: Colors.transparent,
            checkColor: Theme.of(context).colorScheme.primary,
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
        ),
      ),
    );
  }

  Widget getRadio(BuildContext context, String name, PriceOrder value) {
    return SizedBox(
      width: 25,
      height: 25,
      child: Container(
        decoration: new BoxDecoration(
            border: Border.all(width: 1.5, color: Color(0xffB1B1B1)),
            borderRadius: new BorderRadius.circular(8),
            color: Colors.transparent),
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: Colors.black12,
          ),
          child: Radio(
            value: value,
            onChanged: (v) {
              print('fggg');
              print(v);
            },
            groupValue: productController.priceOrder.value,
          ),
        ),
      ),
    );
  }
}
