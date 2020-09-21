import "package:cloud_firestore/cloud_firestore.dart";
import "package:pbas/model/CONSTANTS.dart" as CONSTANTS;
import "package:pbas/model/Post.dart";
import 'package:pbas/model/User.dart';

class DatabaseService {
  Post post;
  //User user;

  //collection references
  final CollectionReference postsCollection = FirebaseFirestore.instance
      .collection(CONSTANTS.posts_reference);
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection(CONSTANTS.users_reference);

  //Get Post List Stream
  Stream<List<Post>> get posts {
    return postsCollection.snapshots().map(_postListFromSnapshot);
  }

  //Post List From Snapshot
  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
     return snapshot.docs.map((doc) {
       Post post= Post(
        title: doc.data()[CONSTANTS.fieldNameTitle].toString() ?? "N/A",
        categoryReference: doc.data()[CONSTANTS.fieldNameCategoryReference].toString() ?? "N/A",
        cityReference: doc.data()[CONSTANTS.fieldNameCityReference].toString() ?? "N/A",
        description: doc.data()[CONSTANTS.fieldNameDescription].toString() ?? "N/A",
        pathPhotoLink: doc.data()[CONSTANTS.fieldNamePathPhotoLink].toString() ?? "N/A",
        storyPhotoLink: doc.data()[CONSTANTS.fieldNameStoryPhotoLink].toString() ?? "N/A",
        uploaderReference: doc.data()[CONSTANTS.fieldNameUploaderReference].toString() ?? "N/A",
        estimatedTimeInMinutes: doc.data()[CONSTANTS.fieldNameEstimatedTimeInMinutes] ?? -1,
        travelDistanceInMeters: doc.data()[CONSTANTS.fieldNameTravelDistanceInMeters] ?? -1,
        user:User(
          userName: "N/A",
          userPictureLink: "https://goster.co/wp-content/uploads/2019/04/n-a-ne-anlama-geliyor.jpg"
        ),
      );

       return post;
    }).toList();
  }

   Post retrieveUser (String reference, Post post)  {
    usersCollection.doc(reference).get().then((value){
      User user= User(
        userName: value.data()[CONSTANTS.fieldNameUserName].toString() ?? "N/A",
        userPictureLink:value.data()[CONSTANTS.fieldNameUserPictureLink].toString() ?? "https://goster.co/wp-content/uploads/2019/04/n-a-ne-anlama-geliyor.jpg",
      );
    }).whenComplete(() => {
    //
    });
  }

}
