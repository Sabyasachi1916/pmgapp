// To parse this JSON data, do
//
//     final followUpList = followUpListFromJson(jsonString);

// To parse this JSON data, do
//
//     final followUpList = followUpListFromJson(jsonString);

import 'dart:convert';

FollowUpList followUpListFromJson(String str) => FollowUpList.fromJson(json.decode(str));

String followUpListToJson(FollowUpList data) => json.encode(data.toJson());

class FollowUpList {
    List<ListElement> list;
    int totalRecord;

    FollowUpList({
        required this.list,
        required this.totalRecord,
    });

    factory FollowUpList.fromJson(Map<String, dynamic> json) => FollowUpList(
        list: List<ListElement>.from(json["List"].map((x) => ListElement.fromJson(x))),
        totalRecord: json["TotalRecord"],
    );

    Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
        "TotalRecord": totalRecord,
    };
}

class ListElement {
    int id;
    int patientId;
    int followUpUserId;
    DateTime followUpDate;
    String notes;
    String followUpType;
    bool isCompleted;
    DateTime createdOn;
    int createdBy;
    bool isDeleted;
    dynamic deletedBy;
    dynamic deletedOn;
    bool isCanceled;
    dynamic canceledBy;
    dynamic canceledOn;
    String createdUser;
    String followUpUser;
    dynamic patientName;
    dynamic patientDob;
    dynamic policyIdNumber;
    dynamic patientSsn;

    ListElement({
        required this.id,
        required this.patientId,
        required this.followUpUserId,
        required this.followUpDate,
        required this.notes,
        required this.followUpType,
        required this.isCompleted,
        required this.createdOn,
        required this.createdBy,
        required this.isDeleted,
        required this.deletedBy,
        required this.deletedOn,
        required this.isCanceled,
        required this.canceledBy,
        required this.canceledOn,
        required this.createdUser,
        required this.followUpUser,
        required this.patientName,
        required this.patientDob,
        required this.policyIdNumber,
        required this.patientSsn,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["Id"],
        patientId: json["PatientId"],
        followUpUserId: json["FollowUpUserId"],
        followUpDate: DateTime.parse(json["FollowUpDate"]),
        notes: json["Notes"],
        followUpType: json["FollowUpType"],
        isCompleted: json["IsCompleted"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        createdBy: json["CreatedBy"],
        isDeleted: json["IsDeleted"],
        deletedBy: json["DeletedBy"],
        deletedOn: json["DeletedOn"],
        isCanceled: json["IsCanceled"],
        canceledBy: json["CanceledBy"],
        canceledOn: json["CanceledOn"],
        createdUser: json["CreatedUser"],
        followUpUser: json["FollowUpUser"],
        patientName: json["PatientName"],
        patientDob: json["PatientDob"],
        policyIdNumber: json["PolicyIdNumber"],
        patientSsn: json["PatientSsn"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "PatientId": patientId,
        "FollowUpUserId": followUpUserId,
        "FollowUpDate": followUpDate.toIso8601String(),
        "Notes": notes,
        "FollowUpType": followUpType,
        "IsCompleted": isCompleted,
        "CreatedOn": createdOn.toIso8601String(),
        "CreatedBy": createdBy,
        "IsDeleted": isDeleted,
        "DeletedBy": deletedBy,
        "DeletedOn": deletedOn,
        "IsCanceled": isCanceled,
        "CanceledBy": canceledBy,
        "CanceledOn": canceledOn,
        "CreatedUser": createdUser,
        "FollowUpUser": followUpUser,
        "PatientName": patientName,
        "PatientDob": patientDob,
        "PolicyIdNumber": policyIdNumber,
        "PatientSsn": patientSsn,
    };
}
