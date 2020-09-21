import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbas/model/User.dart';

class Post {
  final String title;
  final String categoryReference;
  final String cityReference;
  final String description;
  final String pathPhotoLink;
  final String storyPhotoLink;
  final String uploaderReference;
  final int estimatedTimeInMinutes;
  final int travelDistanceInMeters;
   User user;

  Post(
      {this.title,
      this.categoryReference,
      this.cityReference,
      this.description,
      this.pathPhotoLink,
      this.storyPhotoLink,
      this.uploaderReference,
      this.estimatedTimeInMinutes,
      this.travelDistanceInMeters,
      this.user
      });
}
