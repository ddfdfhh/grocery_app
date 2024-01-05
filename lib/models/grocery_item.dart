class GroceryItem {
  final int? id;
  final String name;
  final String description;
  final double price;
  final double sale_price;
  final String imagePath;
  //final bool has_variant;
  //final List<GroceryItem> variants;

  GroceryItem({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.sale_price,
    required this.imagePath,
  });
}

var demoItems = [
  GroceryItem(
      id: 1,
      name: "Organic Bananas",
      description: "7pcs, Priceg",
      price: 4.99,
      sale_price: 4.99,
      imagePath: "assets/images/grocery_images/banana.png"),
];
