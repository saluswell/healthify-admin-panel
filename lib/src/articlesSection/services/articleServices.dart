import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saluwell_admin_panel/utils/appcolors.dart';
import 'package:saluwell_admin_panel/utils/navigatorHelper.dart';
import 'package:saluwell_admin_panel/utils/showsnackbar.dart';

import '../../../utils/firebaseUtils.dart';
import '../models/articleModel.dart';

class ArticleServices {
  ///Create Page
  Future createArticle(ArticleModel articleModel) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection(FirebaseUtils.healthtips).doc();
    return await docRef.set(articleModel.toJson(docRef.id));
  }

  /// show list of pending and approved articles  from admin
  Stream<List<ArticleModel>> streamArticles() {
    //  try {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.healthtips)
        // .where("categoryType", isEqualTo: currentCategory)

        //   .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        //   .where("isApprovedByAdmin", isEqualTo: isApprove)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => ArticleModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///delete article
  Future deleteArticle(String articleID) async {
    return await FirebaseFirestore.instance
        .collection(FirebaseUtils.healthtips)
        .doc(articleID)
        .delete();
  }

  /// update article data without image
  Future updateArticleDetailswithoutImage(
      ArticleModel articleModel, articleID) async {
    return await FirebaseFirestore.instance
        .collection(FirebaseUtils.healthtips)

        //  .where("UserId",isEqualTo: userid)
        .doc(articleID)
        .update({
      'articleTitle': articleModel.articleTitle,
      "articleDescription": articleModel.articleDescription,
    });
  }

  /// update article data without image
  Future approvedRejectArticle(
      ArticleModel articleModel, articleID, bool isApproved) async {
    try {
      return await FirebaseFirestore.instance
          .collection(FirebaseUtils.healthtips)

          //  .where("UserId",isEqualTo: userid)
          .doc(articleID)
          .update({
        'isApprovedByAdmin': isApproved,
        //"articleDescription": articleModel.articleDescription,
      }).whenComplete(() {
        if (isApproved == true) {
          showSnackBarMessage(
              context: navstate.currentState!.context,
              backgroundcolor: AppColors.appcolor,
              contentColor: AppColors.whitecolor,
              content: "Article Approved Successfully");
        } else {
          showSnackBarMessage(
              context: navstate.currentState!.context,
              backgroundcolor: AppColors.redcolor,
              contentColor: AppColors.whitecolor,
              content: "Article Rejected Successfully");
        }
      });
    } on Exception catch (e) {
      showSnackBarMessage(
          backgroundcolor: AppColors.redcolor,
          contentColor: AppColors.whitecolor,
          context: navstate.currentState!.context,
          content: e.toString());
      // TODO
    }
  }

  /// update article data with Image
  Future updateArticleDetailswithImage(
      ArticleModel articleModel, articleID) async {
    return await FirebaseFirestore.instance
        .collection(FirebaseUtils.healthtips)

        //   .where("UserId",isEqualTo: userid)
        .doc(articleID)
        .update({
      'articleTitle': articleModel.articleTitle,
      "articleDescription": articleModel.articleDescription,
      "articleImage": articleModel.articleImage,
    });
  }

  ///delete review
  Future deletePayment(String paymentID) async {
    print(paymentID);
    try {
      return await FirebaseFirestore.instance
          .collection(FirebaseUtils.paymenthistory)
          .doc(paymentID)
          .delete();
    } on FirebaseException catch (e) {
      print(e.toString());

      // TODO
    }
  }
}
