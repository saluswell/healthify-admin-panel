// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

AdminUserModel userModelFromJson(String str) =>
    AdminUserModel.fromJson(json.decode(str));

String userModelToJson(AdminUserModel data) =>
    json.encode(data.toJson(data.userId.toString()));

class AdminUserModel {
  AdminUserModel(
      {this.userId,
      this.emailAdress,
      this.profilePicture,
      this.isApprovedByAdmin,
      this.userType,
      this.dateCreated,
      this.role,
      this.password});

  String? userId;

  String? emailAdress;
  String? profilePicture;
  bool? isApprovedByAdmin;
  String? userType;
  Timestamp? dateCreated;
  String? role;
  String? password;

  factory AdminUserModel.fromJson(Map<String, dynamic> json) => AdminUserModel(
      userId: json["userID"],
      emailAdress: json["emailAdress"],
      profilePicture: json["profilePicture"],
      isApprovedByAdmin: json["isApprovedByAdmin"],
      userType: json["UserType"],
      dateCreated: json["dateCreated"],
      role: json["role"],
      password: json["password"]);

  Map<String, dynamic> toJson(String docID) => {
        "userID": docID,
        "emailAdress": emailAdress,
        "profilePicture": profilePicture,
        "isApprovedByAdmin": isApprovedByAdmin,
        "UserType": userType,
        "dateCreated": dateCreated,
        "role": role,
        "password": password
      };
}
