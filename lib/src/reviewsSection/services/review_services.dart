import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/firebaseUtils.dart';
import '../models/review_model.dart';

class ReviewServices {
  /// Stream dieitian reviews
  Stream<List<ReviewModel>> streamReviewsList() {
    //  try {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.reviews)
        //.where("reviewRecieverID", isEqualTo: getUserID())
        //.where("isApprovedByAdmin", isEqualTo: isApprove)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => ReviewModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///delete review
  Future deleteReview(String reviewID) async {
    print(reviewID);
    try {
      return await FirebaseFirestore.instance
          .collection(FirebaseUtils.reviews)
          .doc(reviewID)
          .delete();
    } on FirebaseException catch (e) {
      print(e.toString());

      // TODO
    }
  }
}
