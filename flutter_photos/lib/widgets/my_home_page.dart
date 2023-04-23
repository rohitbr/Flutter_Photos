import 'package:flutter/material.dart';
import 'package:flutter_photos/view_models/photos_view_model.dart';
import 'package:flutter_photos/widgets/photo_cell.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final photoViewModel = context.watch<PhotoViewModel>();
    final photoList = photoViewModel.photoListModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
        ),
        itemCount: photoList.length,
        itemBuilder: (context, index) {
          return PhotoCell(photo: photoList[index]);
        },
      ),
    );
  }
}
