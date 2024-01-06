import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:saluwell_admin_panel/src/articlesSection/models/articleModel.dart';
import 'package:saluwell_admin_panel/src/articlesSection/services/articleServices.dart';

import '../../../commonWidgets/textfield_widget.dart';
import '../../../commonWidgets/user_profile_header_widget.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/themes.dart';
import '../widgets/articles_card_widget.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  ArticleServices articleServices = ArticleServices();

  List<ArticleModel> searchedContact = [];

  bool isSearchingAllow = false;
  bool isSearched = false;
  List<ArticleModel> contactListDB = [];

  void _searchArticles(String val) async {
    print(contactListDB.length);
    searchedContact.clear();
    for (var i in contactListDB) {
      var lowerCaseString = i.articleTitle.toString().toLowerCase() +
          " " +
          i.articleTitle.toString().toLowerCase() +
          i.articleTitle.toString();

      var defaultCase = i.articleTitle.toString() +
          " " +
          i.articleTitle.toString() +
          i.articleTitle.toString();

      if (lowerCaseString.contains(val) || defaultCase.contains(val)) {
        searchedContact.add(i);
      } else {
        setState(() {
          isSearched = true;
        });
      }
    }
    setState(() {});
  }

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
                children: [
                  Expanded(
                      flex: 5,
                      child: TextFieldWidget(
                        onChanged: (val) {
                          _searchArticles(val);
                          setState(() {});
                        },
                      )),
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
                    "Articles",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 26,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    width: 20,
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
            // StreamProvider.value(
            //     value: articleServices.streamArticles(),
            //     initialData: [ArticleModel()],
            //     builder: (context, child) {
            //       List<ArticleModel> articleList =
            //           context.watch<List<ArticleModel>>();
            //       return articleList.isEmpty
            //           ? const Center(
            //               child: Padding(
            //               padding: EdgeInsets.only(top: 220),
            //               child: Text("No Articles Found!",
            //                   style: TextStyle(
            //                       // fontFamily: 'Gilroy',
            //                       color: AppColors.blackcolor,
            //                       // decoration: TextDecoration.underline,
            //                       fontWeight: FontWeight.w700,
            //                       fontFamily: 'Axiforma',
            //                       fontSize: 13)),
            //             ))
            //           : articleList[0].articleId == null
            //               ? const Padding(
            //                   padding: EdgeInsets.only(top: 100),
            //                   child: CircularProgressIndicator(
            //                     //  size: 30,
            //                     color: AppColors.appcolor,
            //                   ),
            //                 )
            //               : Expanded(
            //                   child: ListView.builder(
            //                       itemCount: articleList.length,
            //                       padding: const EdgeInsets.only(),
            //                       physics: const ScrollPhysics(),
            //                       // The total number of items in the list
            //                       // physics: const NeverScrollableScrollPhysics(),
            //                       itemBuilder: (context, index) {
            //                         // A callback function that returns a widget for each item at the given index
            //                         return Padding(
            //                           padding:
            //                               const EdgeInsets.only(bottom: 10),
            //                           child: ArticlesCardWidget(
            //                             articleModel: articleList[index],
            //                           ),
            //                         );
            //                       }));
            //     })

            StreamProvider.value(
                value: articleServices.streamArticles(),
                initialData: [ArticleModel()],
                builder: (context, child) {
                  contactListDB = context.watch<List<ArticleModel>>();
                  List<ArticleModel> list = context.watch<List<ArticleModel>>();
                  return list.isEmpty
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Text("No Users Found!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                        ))
                      : list[0].userId == null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100.0),
                                child: SpinKitPulse(
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          : list.isEmpty
                              ? Center(
                                  child: Padding(
                                  padding: const EdgeInsets.only(top: 100),
                                  child: Text("No Users Found"),
                                ))
                              : searchedContact.isEmpty
                                  ? isSearched == true
                                      ? Center(
                                          child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 100),
                                          child: Text("NO Users Found"),
                                        ))
                                      : Container(
                                          // height: 550,
                                          // width: MediaQuery.of(context).size.width,

                                          child: Expanded(
                                          child: ListView.builder(
                                              itemCount: contactListDB.length,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.only(),
                                              itemBuilder: (context, i) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: ArticlesCardWidget(
                                                    articleModel: list[i],
                                                  ),
                                                );
                                              }),
                                        ))
                                  : Container(
                                      child: Expanded(
                                      child: ListView.builder(
                                          itemCount: searchedContact.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(),
                                          itemBuilder: (context, i) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: ArticlesCardWidget(
                                                articleModel:
                                                    searchedContact[i],
                                              ),
                                            );
                                          }),
                                    ));
                })
          ],
        ));
  }
}
