import 'package:flutter/material.dart';
import 'package:flutter_photos/models/photo.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_models/photos_view_model.dart';

class PhotoCell extends StatelessWidget {
  final Photo photo;
  const PhotoCell({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final photoViewModel = context.read<PhotoViewModel>();

    return InkWell(
      onTap: () {
        photoViewModel.setSelectedPhoto(photo);
        context.push('/photos/detail');
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                '${photo.id}',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
            ),
            AspectRatio(
                aspectRatio: 4 / 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Image.network(photo.thumbnailUrl),
                )),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Description : ${photo.title}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6.0),
            TextButton.icon(
              onPressed: () => delete(photoViewModel, photo),
              label: const Text('Delete'),
              icon: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }

  void delete(PhotoViewModel photoViewModel, Photo photo) {
    photoViewModel.delete(photo);
  }
}
