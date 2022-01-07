import 'package:intl/intl.dart';

class ItemModel {
  const ItemModel({
    this.id = '',
    required this.imageURL,
    required this.title,
    required this.releaseDate,
  });

  final String id;
  final String imageURL;
  final String title;
  final DateTime releaseDate;

  int get daysLeft {
    return releaseDate.difference(DateTime.now()).inDays;
  }

  String get releaseDateFormatted {
    return DateFormat('yMMMd').format(releaseDate);
  }
}
