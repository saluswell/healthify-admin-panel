// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saluwell_admin_panel/src/usersSection/models/patientQuestionareModel.dart';
import 'package:saluwell_admin_panel/src/usersSection/models/personalInformationModel.dart';
import 'package:saluwell_admin_panel/src/usersSection/models/professionalInformationModel.dart';

import 'bankingInformationModel.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) =>
    json.encode(data.toJson(data.userId.toString()));

class UserModel {
  UserModel(
      {this.userId,
      this.userName,
      this.emailAdress,
      this.profilePicture,
      this.isApprovedByAdmin,
      this.userType,
      this.dateCreated,
      this.availableDays,
      this.availabletimeSlots,
      this.patientQuestionareModel,
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
  List<dynamic>? availableDays;
  List<dynamic>? availabletimeSlots;
  PatientQuestionareModel? patientQuestionareModel;
  PersonalInformationModel? personalInformationModel;
  ProfessionalInformationModel? professionalInformationModel;
  BankingInformationModel? bankingInformationModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userID"],
        userName: json["userName"],
        emailAdress: json["emailAdress"],
        profilePicture: json["profilePicture"],
        isApprovedByAdmin: json["isApprovedByAdmin"],
        userType: json["UserType"],
        dateCreated: json["dateCreated"],
        availableDays: json["availableDays"],
        availabletimeSlots: json["availabletimeSlots"],
        patientQuestionareModel:
            PatientQuestionareModel.fromJson(json["PatientQuestionareModel"]),
        personalInformationModel:
            PersonalInformationModel.fromJson(json["PersonalInformationModel"]),
        professionalInformationModel: ProfessionalInformationModel.fromJson(
            json["ProfessionalInformationModel"]),
        bankingInformationModel:
            BankingInformationModel.fromJson(json["BankingInformationModel"]),
      );

  Map<String, dynamic> toJson(String docID) => {
        "userID": docID,
        "userName": userName,
        "emailAdress": emailAdress,
        "profilePicture": profilePicture,
        "isApprovedByAdmin": isApprovedByAdmin,
        "UserType": userType,
        "dateCreated": dateCreated,
        "availableDays": availableDays,
        "availabletimeSlots": availabletimeSlots,
        "PatientQuestionareModel": patientQuestionareModel!.toJson(docID),
        "PersonalInformationModel": personalInformationModel!.toJson(docID),
        "ProfessionalInformationModel":
            professionalInformationModel!.toJson(docID),
        "BankingInformationModel": bankingInformationModel!.toJson(docID),
      };
}
