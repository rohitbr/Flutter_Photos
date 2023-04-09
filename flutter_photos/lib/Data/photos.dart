import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/photo.dart';

class Photos {
  static Future<List<Photo>> fetchPhotosList() async {
    final response = await getPhotosResponseObjectFromServer();
    final jsonResponse =
        await decodeOrDeserializeStringToMapOrNativeDataStructure(response);
    final photosList = mapEachElementOfArray(jsonResponse);
    return photosList;
  }

  static Future<http.Response> getPhotosResponseObjectFromServer() async {
    var client = http.Client();
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    return (response);
    // Here the get is returning a response which has a body which is a string of json.
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
      decodeOrDeserializeStringToMapOrNativeDataStructure(
          http.Response response) async {
    var jsonResponse = convert.jsonDecode(response.body) as List;
    return jsonResponse;
  }

  static Future<List<Photo>> mapEachElementOfArray(
      List<dynamic> listOfObjects) async {
    final mappedPhotoList = listOfObjects.map((e) {
      final mappedPhoto = Photo.fromJson(e as Map<String, dynamic>);
      return mappedPhoto;
    });
    final photoList = mappedPhotoList.toList();
    return photoList;
  }
}
