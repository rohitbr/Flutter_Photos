import 'package:flutter/material.dart';
import 'package:flutter_photos/view_models/photos_view_model.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'models/photo.dart';

class AddNewPhotoPage extends StatelessWidget {
  const AddNewPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final photoViewModel = context.read<PhotoViewModel>();
    final photo = photoViewModel.selectedPhoto;
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhotoDetail'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    '${photo?.id}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                AspectRatio(
                    aspectRatio: 4 / 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Image.network(photo?.thumbnailUrl ?? ''),
                    )),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Description : ${photo?.title}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 6.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextButton.icon(
              onPressed: () => delete(context, photoViewModel, photo),
              label: const Text(
                'Delete',
                style: TextStyle(fontSize: 24),
              ),
              icon: const Icon(
                Icons.delete,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void delete(
      BuildContext context, PhotoViewModel photoViewModel, Photo? photo) {
    photo != null ? photoViewModel.delete(photo) : {};
    if (context.canPop()) {
      context.pop();
    }
  }
}
