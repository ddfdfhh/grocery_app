import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/models/category.dart';
import 'package:flutter/material.dart';
import 'package:citymall/models/category_item.dart';

class CategoryCardWidget extends StatelessWidget {
  CategoryCardWidget(
      {Key? key, required this.item, this.color = Colors.blue})
      : super(key: key);
  final Category item;

  final height = 200.0;

  final width = 175.0;

  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: color.withOpacity(0.7),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 140,
            child: imageWidget(),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              item!.name!,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageWidget() {
    return Container(
        child: CachedNetworkImage(
          imageUrl: Uri.encodeFull(
              baseUrl+'/storage/categories/${item!.image!}'),
          placeholder: (context, url) => Center(
              child: const CircularProgressIndicator()),
          errorWidget: (context, url, error) => Image.asset('images/no-image.jpg'),
        ));
  }
}
