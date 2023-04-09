/*
{
    "albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "https://via.placeholder.com/600/92c952",
    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
  }
  */

// import 'package:json_annotation/json_annotation.dart';
// part 'photo.g.dart';

// @JsonSerializable(explicitToJson: true)
// class Photo {
//   final int albumId;
//   final int id;
//   final String title;
//   final String thumbnailUrl;

//   Photo({
//     required this.albumId,
//     required this.id,
//     required this.title,
//     required this.thumbnailUrl,
//   });

//   factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

//   Map<String, dynamic> toJson() => _$PhotoToJson(this);
// }

import 'package:freezed_annotation/freezed_annotation.dart';
part 'photo.freezed.dart';
part 'photo.g.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({
    required int albumId,
    required int id,
    required String title,
    required String thumbnailUrl,
  }) = _Photo;

  factory Photo.fromJson(Map<String, Object?> json) => _$PhotoFromJson(json);
}
