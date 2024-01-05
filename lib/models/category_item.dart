class CategoryItem {
  final int? id;
  final String name;
  final String imagePath;

  CategoryItem({this.id, required this.name, required this.imagePath});
}

var categoryItemsDemo = [
  CategoryItem(
    name: "Meat",
    imagePath: "assets/images/meat.png",
  ),
  CategoryItem(
    name: "Cooking Oil",
    imagePath: "assets/images/fruits.png",
  ),
  CategoryItem(
    name: "Ginbger",
    imagePath: "assets/images/ginger.png",
  ),

];
