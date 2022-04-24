class PhotoItem {
  final String name;
  final String authorName;
  final String urlSmallImage;
  final String urlBigImage;

  PhotoItem({
    required this.name,
    required this.authorName,
    required this.urlSmallImage,
    required this.urlBigImage,
  });

  factory PhotoItem.fromJson(Map<String, dynamic> json) => PhotoItem(
    name: json['alt_description'] ?? '',
    authorName: json['user']['name'] ?? '',
    urlSmallImage: json["urls"]['small'] ?? '',
    urlBigImage: json["urls"]['full'] ?? '',
  );
}
