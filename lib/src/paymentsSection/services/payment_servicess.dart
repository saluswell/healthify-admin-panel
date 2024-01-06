import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/firebaseUtils.dart';
import '../models/paymentModel.dart';

class PaymenstServices {
  Stream<List<PaymentModel>> streamPaymentsList() {
    //  try {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.paymenthistory)
        //.where("reviewRecieverID", isEqualTo: getUserID())
        //.where("isApprovedByAdmin", isEqualTo: isApprove)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => PaymentModel.fromJson(singleDoc.data()))
            .toList());
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
