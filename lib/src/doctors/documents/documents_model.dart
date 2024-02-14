// To parse this JSON data, do
//
//     final documentList = documentListFromJson(jsonString);

import 'dart:convert';

DocumentList documentListFromJson(String str) => DocumentList.fromJson(json.decode(str));

String documentListToJson(DocumentList data) => json.encode(data.toJson());

class DocumentList {
    List<Document> list;
    int totalRecord;

    DocumentList({
        required this.list,
        required this.totalRecord,
    });

    factory DocumentList.fromJson(Map<String, dynamic> json) => DocumentList(
        list: List<Document>.from(json["List"].map((x) => Document.fromJson(x))),
        totalRecord: json["TotalRecord"],
    );

    Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
        "TotalRecord": totalRecord,
    };
}

class Document {
    int id;
    String leadNumber;
    String documentUrl;
    String documentType;
    String documentId;
    bool isDeleted;
    DateTime createdOn;
    int createdBy;
    String createdUser;

    Document({
        required this.id,
        required this.leadNumber,
        required this.documentUrl,
        required this.documentType,
        required this.documentId,
        required this.isDeleted,
        required this.createdOn,
        required this.createdBy,
        required this.createdUser,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["Id"],
        leadNumber: json["LeadNumber"],
        documentUrl: json["DocumentUrl"],
        documentType: json["DocumentType"],
        documentId: json["DocumentId"],
        isDeleted: json["IsDeleted"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        createdBy: json["CreatedBy"],
        createdUser: json["CreatedUser"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "LeadNumber": leadNumber,
        "DocumentUrl": documentUrl,
        "DocumentType": documentType,
        "DocumentId": documentId,
        "IsDeleted": isDeleted,
        "CreatedOn": createdOn.toIso8601String(),
        "CreatedBy": createdBy,
        "CreatedUser": createdUser,
    };
}
