// To parse this JSON data, do
//
//     final appointmentModel = appointmentModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saluwell_admin_panel/src/appointmnetsSection/models/paymentPlanModel.dart';

import '../../usersSection/models/patientQuestionareModel.dart';

AppointmentModel appointmentModelFromJson(String str) =>
    AppointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(AppointmentModel data) =>
    json.encode(data.toJson(data.appointmentId.toString()));

class AppointmentModel {
  AppointmentModel(
      {this.appointmentId,
      this.appointmentDateTime,
      this.noteFromPatient,
      this.dateCreated,
      this.isApproveByDietitian,
      this.appointmentStatus,
      this.patientName,
      this.patientId,
      this.patientProfilePic,
      this.dietitianName,
      this.dietitianId,
      this.dietitianProfilePic,
      this.appointmentFees,
      this.isReviewGivenByPatient,
      this.isReviewGivenByDietitian,
      this.from,
      this.to,
      this.payementPlansModel,
      this.patientQuestionareModel,
      this.timeslot,
      this.combineDateTime});

  String? appointmentId;
  Timestamp? appointmentDateTime;
  String? noteFromPatient;
  Timestamp? dateCreated;
  bool? isApproveByDietitian;
  String? appointmentStatus;
  String? patientName;
  String? patientId;
  String? patientProfilePic;
  String? dietitianName;
  String? dietitianId;
  String? dietitianProfilePic;
  String? appointmentFees;
  bool? isReviewGivenByPatient;
  bool? isReviewGivenByDietitian;
  Timestamp? from;
  Timestamp? to;
  PayementPlansModel? payementPlansModel;
  PatientQuestionareModel? patientQuestionareModel;
  String? timeslot;
  Timestamp? combineDateTime;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        appointmentId: json["appointmentID"],
        appointmentDateTime: json["appointmentDateTime"],
        noteFromPatient: json["noteFromPatient"],
        dateCreated: json["dateCreated"],
        isApproveByDietitian: json["isApproveByDietitian"],
        appointmentStatus: json["appointmentStatus"],
        patientName: json["patientName"],
        patientId: json["patientID"],
        patientProfilePic: json["patientProfilePic"],
        dietitianName: json["DietitianName"],
        dietitianId: json["DietitianID"],
        dietitianProfilePic: json["DietitianProfilePic"],
        appointmentFees: json["appointmentFees"],
        isReviewGivenByPatient: json["isReviewGivenByPatient"],
        isReviewGivenByDietitian: json["isReviewGivenByDietitian"],
        from: json["from"],
        to: json["to"],
        payementPlansModel:
            PayementPlansModel.fromJson(json["payementPlansModel"]),
        patientQuestionareModel:
            PatientQuestionareModel.fromJson(json["payementPlansModel"]),
        timeslot: json["timeslot"],
        combineDateTime: json["combineDateTime"],

        //  timeSlotModel: json["timeSlotModel"],
      );

  Map<String, dynamic> toJson(String id) => {
        "appointmentID": id,
        "appointmentDateTime": appointmentDateTime,
        "noteFromPatient": noteFromPatient,
        "dateCreated": dateCreated,
        "isApproveByDietitian": isApproveByDietitian,
        "appointmentStatus": appointmentStatus,
        "patientName": patientName,
        "patientID": patientId,
        "patientProfilePic": patientProfilePic,
        "DietitianName": dietitianName,
        "DietitianID": dietitianId,
        "DietitianProfilePic": dietitianProfilePic,
        "appointmentFees": appointmentFees,
        "isReviewGivenByPatient": isReviewGivenByPatient,
        "isReviewGivenByDietitian": isReviewGivenByDietitian,
        "from": from,
        "to": to,
        "payementPlansModel": payementPlansModel!.toJson(),
        "patientQuestionareModel": patientQuestionareModel!.toJson(id),
        "timeslot": timeslot,
        "combineDateTime": combineDateTime,
      };
}
