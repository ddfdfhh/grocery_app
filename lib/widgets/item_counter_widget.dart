import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/dialog/dialog.dart';
import 'package:citymall/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCounterWidget extends StatefulWidget {
  final Function? qtyUpdateCallback;
  int initialQty;
  int maxQty;
  ItemCounterWidget(
      {Key? key,
      this.qtyUpdateCallback,
      required this.initialQty,
      required this.maxQty})
      : super(key: key);

  @override
  _ItemCounterWidgetState createState() => _ItemCounterWidgetState();
}

class _ItemCounterWidgetState extends State<ItemCounterWidget> {
  //int amount = widget.initialQty;
CartController cartController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if(cartController.isUpdatingCart.value){
                    return;
                  }
                  else
                    incrementAmount();
                },
                child: Container(
                    height: 30,
                    width: 30,
                    color: AppTheme(context: context).colors['primary'],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: IconButton(
                            iconSize: 14,
                            color: Colors.white,
                            icon: Icon(Icons.add),
                            onPressed: () {
                              if(cartController.isUpdatingCart.value){
                                return;
                              }
                              else
                                incrementAmount();
                            },
                          ),
                        ),
                        Expanded(child: SizedBox(height: 10))
                      ],
                    ))),
            Expanded(
                child: Container(
              child: Text(
                textAlign: TextAlign.center,
                widget.initialQty.toString(),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )),
            InkWell(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if(cartController.isUpdatingCart.value){
                    return;
                  }
                  else
                    decrementAmount();
                },
                child: Container(
                    height: 30,
                    width: 30,
                    color: AppTheme(context: context).colors['primary'],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: IconButton(
                            iconSize: 14,
                            color: Colors.white,
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              if(cartController.isUpdatingCart.value){
                                return;
                              }
                              else
                                decrementAmount();
                            },
                          ),
                        ),
                        Expanded(child: SizedBox(height: 10))
                      ],
                    ))),
          ],
        ));
  }

  void incrementAmount() {
    setState(() {
      if (widget.initialQty < widget.maxQty) {
        widget.initialQty = widget.initialQty + 1;
        updateParent('plus', widget.initialQty);
      } else
        showAlertDialog(
            context,
            DialogType.warning,
            'Maximum ${widget.maxQty} items can be added to cart',
            'Limit Reached',
            () {});
    });
  }

  void decrementAmount() {
    if (widget.initialQty <= 1) return;
    setState(() {
      widget.initialQty = widget.initialQty - 1;
      updateParent('minus', widget.initialQty);
    });
  }

  void updateParent(mode, amount) {
    if (widget.qtyUpdateCallback != null) {
      widget.qtyUpdateCallback!(mode, amount);
    }
  }
}
