// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saluwell_admin_panel/src/usersSection/models/personalInformationModel.dart';
import 'package:saluwell_admin_panel/src/usersSection/models/professionalInformationModel.dart';

import 'bankingInformationModel.dart';

UserModelDietitian userModelFromJson(String str) =>
    UserModelDietitian.fromJson(json.decode(str));

String userModelToJson(UserModelDietitian data) =>
    json.encode(data.toJson(data.userId.toString()));

class UserModelDietitian {
  UserModelDietitian(
      {this.userId,
      this.userName,
      this.emailAdress,
      this.profilePicture,
      this.isApprovedByAdmin,
      this.userType,
      this.dateCreated,
      this.personalInformationModel,
      this.professionalInformationModel,
      this.bankingInformationModel});

  String? userId;
  String? userName;
  String? emailAdress;
  String? profilePicture;
  bool? isApprovedByAdmin;
  String? userType;
  Timestamp? dateCreated;
  PersonalInformationModel? personalInformationModel;
  BankingInformationModel? bankingInformationModel;
  ProfessionalInformationModel? professionalInformationModel;

  factory UserModelDietitian.fromJson(Map<String, dynamic> json) =>
      UserModelDietitian(
        userId: json["userID"],
        userName: json["userName"],
        emailAdress: json["emailAdress"],
        profilePicture: json["profilePicture"],
        isApprovedByAdmin: json["isApprovedByAdmin"],
        userType: json["UserType"],
        dateCreated: json["dateCreated"],
        personalInformationModel:
            PersonalInformationModel.fromJson(json["PersonalInformationModel"]),
        bankingInformationModel:
            BankingInformationModel.fromJson(json["BankingInformationModel"]),
        professionalInformationModel: ProfessionalInformationModel.fromJson(
            json["ProfessionalInformationModel"]),
      );

  Map<String, dynamic> toJson(String docID) => {
        "userID": docID,
        "userName": userName,
        "emailAdress": emailAdress,
        "profilePicture": profilePicture,
        "isApprovedByAdmin": isApprovedByAdmin,
        "UserType": userType,
        "dateCreated": dateCreated,
        "PersonalInformationModel": personalInformationModel!.toJson(docID),
        "BankingInformationModel": bankingInformationModel!.toJson(docID),
        "ProfessionalInformationModel":
            professionalInformationModel!.toJson(docID),
      };
}
