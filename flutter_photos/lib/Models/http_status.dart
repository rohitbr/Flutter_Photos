import 'package:flutter_photos/models/photo.dart';

class Success {
  List<Photo> response;
  Success({
    required this.response,
  });
}

class Failure {
  int code;
  Object errorResponse;
  Failure({
    required this.code,
    required this.errorResponse,
  });
}
