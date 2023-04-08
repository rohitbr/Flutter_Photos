import 'package:flutter/material.dart';
import 'package:flutter_photos/photo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<Photo>> fetchPhotosList() async {
  final response = await getPhotosResponseObjectFromServer();
  final jsonResponse =
      await decodeOrDeserializeStringToMapOrNativeDataStructure(response);
  final photosList = mapEachElementOfArray(jsonResponse);
  return photosList;
}

void main() {
  runApp(const MyApp());
}

Future<http.Response> getPhotosResponseObjectFromServer() async {
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

Future<List<dynamic>> decodeOrDeserializeStringToMapOrNativeDataStructure(
    http.Response response) async {
  var jsonResponse = convert.jsonDecode(response.body) as List;
  return jsonResponse;
}

Future<List<Photo>> mapEachElementOfArray(List<dynamic> listOfObjects) async {
  final mappedPhotoList = listOfObjects.map((e) {
    final mappedPhoto = Photo.fromJson(e as Map<String, dynamic>);
    return mappedPhoto;
  });
  final photoList = mappedPhotoList.toList();
  return photoList;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotosList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
