import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saluwell_admin_panel/src/reviewsSection/services/review_services.dart';

import '../../../commonWidgets/textfield_widget.dart';
import '../../../commonWidgets/user_profile_header_widget.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/themes.dart';
import '../models/review_model.dart';
import '../widgets/reviews_card_widget.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  ReviewServices reviewServices = ReviewServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.greyColor,
        body: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(flex: 5, child: TextFieldWidget()),
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(flex: 2, child: UserProfileHeaderWidget())
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reviews",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 26,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // Container(
                  //   height: 42,
                  //   width: 110,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(11),
                  //       color: AppColors.blueColor),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Add New",
                  //         style: fontW5S12(context)!.copyWith(
                  //             fontSize: 12,
                  //             color: AppColors.whiteColor,
                  //             fontWeight: FontWeight.w700),
                  //       ),
                  //       const SizedBox(
                  //         width: 3,
                  //       ),
                  //       Icon(
                  //         Icons.add,
                  //         size: 18,
                  //         color: AppColors.whiteColor,
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            StreamProvider.value(
                value: reviewServices.streamReviewsList(),
                initialData: [ReviewModel()],
                builder: (context, child) {
                  List<ReviewModel> reviewList =
                      context.watch<List<ReviewModel>>();
                  return reviewList.isEmpty
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.only(top: 220),
                          child: Text("No reviews Found!",
                              style: TextStyle(
                                  // fontFamily: 'Gilroy',
                                  color: AppColors.blackcolor,
                                  // decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Axiforma',
                                  fontSize: 13)),
                        ))
                      : reviewList[0].reviewId == null
                          ? const Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: CircularProgressIndicator(
                                //  size: 30,
                                color: AppColors.appcolor,
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: reviewList.length,
                                  padding: const EdgeInsets.only(),
                                  physics: const ScrollPhysics(),
                                  // The total number of items in the list
                                  // physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    // A callback function that returns a widget for each item at the given index
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: ReviewsCardWidget(
                                        reviewModel: reviewList[index],
                                      ),
                                    );
                                  }));
                })
          ],
        ));
  }
}
