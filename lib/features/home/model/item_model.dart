class ItemModel {
  const ItemModel({
    required this.imageURL,
    required this.title,
    required this.releaseDate,
  });

  final String imageURL;
  final String title;
  final String releaseDate;

  int get daysLeft {
    return 27;
  }
}
