import 'package:flutter_photos/widgets/my_home_page.dart';
import 'package:go_router/go_router.dart';

import 'go_to_photo_detail.dart';

final router = GoRouter(
  initialLocation: '/photos',
  routes: [
    GoRoute(
      path: '/photos',
      builder: (context, state) {
        return const MyHomePage(
          title: 'My home page',
        );
      },
      routes: [
        GoRoute(
          path: 'detail',
          builder: (context, state) {
            return const AddNewPhotoPage();
          },
        )
      ],
    ),
  ],
);
