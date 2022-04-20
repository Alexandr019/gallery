import 'package:dio/dio.dart';
import 'package:gallery/photo_item.dart';

class GalleryRepo {
  Future<List<PhotoItem>> fetchImages() async {
    final json = await Dio().get(
        "https://api.unsplash.com/search/photos?per_page=30&client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9&query=nature");

    final data = json.data;

    List<Map<String, dynamic>> list = data['results'];

    return list.map((e) => PhotoItem.fromJson(e)).toList();
  }
}