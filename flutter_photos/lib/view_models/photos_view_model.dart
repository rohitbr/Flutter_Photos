// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_photos/models/http_status.dart';
import 'package:flutter_photos/models/photo.dart';

import '../service/photo_service.dart';

class PhotoViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Photo> _photosListModel = [];
  Photo? _selectedPhoto;
  PhotoViewModel() {
    fetchPhotos();
  }

  bool get loading => _loading;
  List<Photo> get photoListModel => _photosListModel;
  Photo? get selectedPhoto => _selectedPhoto;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setPhotosListModel(List<Photo> photoListModel) {
    _photosListModel = photoListModel;
  }

  void fetchPhotos() async {
    setLoading(true);
    final photoObject = await PhotosService.getPhotosResponseObjectFromServer();
    if (photoObject is Success) {
      var photoList = photoObject.response;
      // Note this url gives 5000 pictures. So trim to 10 pictures for our purpose
      final trimmedPhotoList = photoList.getRange(0, 10).toList();
      setPhotosListModel(trimmedPhotoList);
    } else {}
    setLoading(false);
  }

  void delete(Photo photo) {
    _photosListModel.removeWhere((element) => element.id == photo.id);
    notifyListeners();
  }

  void setSelectedPhoto(Photo photo) {
    _selectedPhoto = photo;
  }
}
