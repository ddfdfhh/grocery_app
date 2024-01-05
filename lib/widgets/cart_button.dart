import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/item_counter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartButton extends StatelessWidget {
   Function qtyUpdateCallback;
   bool disabled;
    int maxQtyAllowed;
   int initialQty;
  CartButton({required this.qtyUpdateCallback,
    this.maxQtyAllowed=5,
    this.initialQty=0,
    this.disabled=false});

  var is_clicked = false.obs;
  void onClicked() {
    qtyUpdateCallback('plus',1);
    is_clicked.value = !is_clicked.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width:double.infinity, // <-- Your width
        height: 30, // <-- Your height
        child:Obx(() => is_clicked.value || initialQty>0
        ?ItemCounterWidget(qtyUpdateCallback:qtyUpdateCallback,initialQty: initialQty>0?initialQty:1,maxQty: maxQtyAllowed,)
        : ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor:AppTheme(context:context).colors['primary'],

              shape: RoundedRectangleBorder(
                  side:BorderSide(width:1,color:AppTheme(context:context).colors['primary']),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(11),
                    bottomRight: Radius.circular(10),
                  )
              ),
            ),
            onPressed: () {
              if(!disabled)
                onClicked();
              else{
                Get.snackbar(
                  "Error",
                  "Please select a variant first",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.add_alert),
                );
              }
            },
            icon: Icon(
              // <-- Icon
              CupertinoIcons.plus,
              size: 13.0,
            ),
            label: Text("Add"))));
  }
}
