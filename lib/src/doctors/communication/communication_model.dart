// To parse this JSON data, do
//
//     final communicationList = communicationListFromJson(jsonString);

import 'dart:convert';

CommunicationList communicationListFromJson(String str) => CommunicationList.fromJson(json.decode(str));

String communicationListToJson(CommunicationList data) => json.encode(data.toJson());

class CommunicationList {
    List<CommunicationListElement> list;
    int totalRecord;

    CommunicationList({
        required this.list,
        required this.totalRecord,
    });

    factory CommunicationList.fromJson(Map<String, dynamic> json) => CommunicationList(
        list: List<CommunicationListElement>.from(json["List"].map((x) => CommunicationListElement.fromJson(x))),
        totalRecord: json["TotalRecord"],
    );

    Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
        "TotalRecord": totalRecord,
    };
}

class CommunicationListElement {
    int id;
    String leadNumber;
    int messageTypeId;
    String messageTo;
    String messageContent;
    DateTime sentOn;
    int sentBy;
    int transactionTypeId;
    String transactionType;
    String messageType;
    String sentUser;
    dynamic countryCode;

    CommunicationListElement({
        required this.id,
        required this.leadNumber,
        required this.messageTypeId,
        required this.messageTo,
        required this.messageContent,
        required this.sentOn,
        required this.sentBy,
        required this.transactionTypeId,
        required this.transactionType,
        required this.messageType,
        required this.sentUser,
        required this.countryCode,
    });

    factory CommunicationListElement.fromJson(Map<String, dynamic> json) => CommunicationListElement(
        id: json["Id"],
        leadNumber: json["LeadNumber"],
        messageTypeId: json["MessageTypeId"],
        messageTo: json["MessageTo"],
        messageContent: json["MessageContent"],
        sentOn: DateTime.parse(json["SentOn"]),
        sentBy: json["SentBy"],
        transactionTypeId: json["TransactionTypeId"],
        transactionType: json["TransactionType"],
        messageType: json["MessageType"],
        sentUser: json["SentUser"],
        countryCode: json["CountryCode"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "LeadNumber": leadNumber,
        "MessageTypeId": messageTypeId,
        "MessageTo": messageTo,
        "MessageContent": messageContent,
        "SentOn": sentOn.toIso8601String(),
        "SentBy": sentBy,
        "TransactionTypeId": transactionTypeId,
        "TransactionType": transactionType,
        "MessageType": messageType,
        "SentUser": sentUser,
        "CountryCode": countryCode,
    };
}
