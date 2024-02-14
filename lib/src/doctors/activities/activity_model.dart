// To parse this JSON data, do
//
//     final activityListModel = activityListModelFromJson(jsonString);

import 'dart:convert';

ActivityListModel activityListModelFromJson(String str) => ActivityListModel.fromJson(json.decode(str));

String activityListModelToJson(ActivityListModel data) => json.encode(data.toJson());

class ActivityListModel {
    List<Activity> list;
    int totalRecord;

    ActivityListModel({
        required this.list,
        required this.totalRecord,
    });

    factory ActivityListModel.fromJson(Map<String, dynamic> json) => ActivityListModel(
        list: List<Activity>.from(json["List"].map((x) => Activity.fromJson(x))),
        totalRecord: json["TotalRecord"],
    );

    Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
        "TotalRecord": totalRecord,
    };
}

class Activity {
    int id;
    int userId;
    String username;
    int activityLogTypeId;
    String activityLogName;
    String leadNumber;
    DateTime createdOn;
    String description;
    String otherInfo;

    Activity({
        required this.id,
        required this.userId,
        required this.username,
        required this.activityLogTypeId,
        required this.activityLogName,
        required this.leadNumber,
        required this.createdOn,
        required this.description,
        required this.otherInfo,
    });

    factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["Id"],
        userId: json["UserId"],
        username: json["Username"],
        activityLogTypeId: json["ActivityLogTypeId"],
        activityLogName: json["ActivityLogName"],
        leadNumber: json["LeadNumber"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        description: json["Description"],
        otherInfo: json["OtherInfo"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "Username": username,
        "ActivityLogTypeId": activityLogTypeId,
        "ActivityLogName": activityLogName,
        "LeadNumber": leadNumber,
        "CreatedOn": createdOn.toIso8601String(),
        "Description": description,
        "OtherInfo": otherInfo,
    };
}


