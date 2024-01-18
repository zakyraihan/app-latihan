class Item {
  String namaItem;
  double hargaItem;
  bool status;

  Item(this.namaItem, this.hargaItem, this.status);
}

List<Item> itemList = [
  Item('pepsodend', 8000, true),
  Item('shampo', 10000, false),
  Item('sabun', 18000, true),
];
