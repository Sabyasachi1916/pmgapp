// To parse this JSON data, do
//
//     final noteList = noteListFromJson(jsonString);

// To parse this JSON data, do
//
//     final apsImageList = apsImageListFromJson(jsonString);

import 'dart:convert';

List<ApsImage> apsImageListFromJson(String str) => List<ApsImage>.from(json.decode(str).map((x) => ApsImage.fromJson(x)));

String apsImageListToJson(List<ApsImage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApsImage {
    int id;
    String leadNumber;
    int apsId;
    int woundId;
    int apsIndex;
    String image;
    bool isDeleted;
    DateTime createdOn;
    int createdBy;
    dynamic deletedOn;
    dynamic deletedBy;

    ApsImage({
        required this.id,
        required this.leadNumber,
        required this.apsId,
        required this.woundId,
        required this.apsIndex,
        required this.image,
        required this.isDeleted,
        required this.createdOn,
        required this.createdBy,
        required this.deletedOn,
        required this.deletedBy,
    });

    factory ApsImage.fromJson(Map<String, dynamic> json) => ApsImage(
        id: json["Id"],
        leadNumber: json["LeadNumber"],
        apsId: json["ApsId"],
        woundId: json["WoundId"],
        apsIndex: json["ApsIndex"],
        image: json["Image"],
        isDeleted: json["IsDeleted"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        createdBy: json["CreatedBy"],
        deletedOn: json["DeletedOn"],
        deletedBy: json["DeletedBy"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "LeadNumber": leadNumber,
        "ApsId": apsId,
        "WoundId": woundId,
        "ApsIndex": apsIndex,
        "Image": image,
        "IsDeleted": isDeleted,
        "CreatedOn": createdOn.toIso8601String(),
        "CreatedBy": createdBy,
        "DeletedOn": deletedOn,
        "DeletedBy": deletedBy,
    };
}
