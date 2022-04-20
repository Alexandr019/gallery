import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/gallery_repo.dart';
import 'package:gallery/photo_item.dart';

class GalleryCubit extends Cubit<GalleryState> {
  final GalleryRepo _galleryRepo = GalleryRepo();

  GalleryCubit() : super(GalleryState());

  void fetchImages() async {
    emit(GalleryState(isLoading: true));
    List<PhotoItem> photos = await _galleryRepo.fetchImages();
    emit(GalleryState(photos: photos));
  }
}

class GalleryState {
  final List<PhotoItem> photos;
  final bool isLoading;

  GalleryState({this.isLoading = false, this.photos = const []});
}
