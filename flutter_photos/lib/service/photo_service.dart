import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/http_status.dart';
import '../models/photo.dart';

class PhotosService {
  static Future<Object> getPhotosResponseObjectFromServer() async {
    try {
      var client = http.Client();
      final response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

      if (response.statusCode == 200) {
        final jsonResponse =
            await _decodeOrDeserializeStringToMapOrNativeDataStructure(
                response);
        final photosList = await _mapEachElementOfArray(jsonResponse);
        return Success(response: photosList);
      } else {
        return Failure(code: 100, errorResponse: 'Invalid response');
      }
    } on HttpException {
      return Failure(code: 101, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: 102, errorResponse: 'Invalid format');
    } catch (e) {
      return Failure(code: 103, errorResponse: 'Unknown response');
    }

    // Here the response object returns a response which has a body which is a string of json.
    /* "[
  {
    "albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "https://via.placeholder.com/600/92c952",
    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
  },
  {
    "albumId": 1,
    "id": 2,
    "title": "reprehenderit est deserunt velit ipsam",
    "url": "https://via.placeholder.com/600/771796",
    "thumbnailUrl": "https://via.placeholder.com/150/771796"
  },
  */
  }

  static Future<List<dynamic>>
      _decodeOrDeserializeStringToMapOrNativeDataStructure(
          http.Response response) async {
    var jsonResponse = convert.jsonDecode(response.body) as List;
    return jsonResponse;
  }

  static Future<List<Photo>> _mapEachElementOfArray(
      List<dynamic> listOfObjects) async {
    final mappedPhotoList = listOfObjects.map((e) {
      final mappedPhoto = Photo.fromJson(e as Map<String, dynamic>);
      return mappedPhoto;
    });
    final photoList = mappedPhotoList.toList();
    return photoList;
  }
}
