// To parse this JSON data, do
//
//     final patientInfoResponse = patientInfoResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final patientInfoResponse = patientInfoResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final patientInfoResponse = patientInfoResponseFromJson(jsonString);

import 'dart:convert';

PatientInfoResponse patientInfoResponseFromJson(String str) => PatientInfoResponse.fromJson(json.decode(str));

String patientInfoResponseToJson(PatientInfoResponse data) => json.encode(data.toJson());

class PatientInfoResponse {
    List<ListElement> list;
    int totalRecord;

    PatientInfoResponse({
        required this.list,
        required this.totalRecord,
    });

    factory PatientInfoResponse.fromJson(Map<String, dynamic> json) => PatientInfoResponse(
        list: List<ListElement>.from(json["List"].map((x) => ListElement.fromJson(x))),
        totalRecord: json["TotalRecord"],
    );

    Map<String, dynamic> toJson() => {
        "List": List<dynamic>.from(list.map((x) => x.toJson())),
        "TotalRecord": totalRecord,
    };
}

class ListElement {
    int patientid;
    int patientAge;
    String? patGender;
    String? ethnicity;
    String? race;
    String? latestHt;
    String? latestWt;
    double? latestBmi;
    dynamic surgHistDate;
    String? surgHistProc;
    String? famHistProb;
    String? whtSYrLvlFLchlCnsmptn;
    String? dyrHvYVrSmkdTbcc;
    dynamic hwMnyChldrnDyHv;
    dynamic covidPositive;

    ListElement({
        required this.patientid,
        required this.patientAge,
        required this.patGender,
        required this.ethnicity,
        required this.race,
        required this.latestHt,
        required this.latestWt,
        required this.latestBmi,
        required this.surgHistDate,
        required this.surgHistProc,
        required this.famHistProb,
        required this.whtSYrLvlFLchlCnsmptn,
        required this.dyrHvYVrSmkdTbcc,
        required this.hwMnyChldrnDyHv,
        required this.covidPositive,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        patientid: json["Patientid"],
        patientAge: json["PatientAge"],
        patGender: json["PatGender"],
        ethnicity: json["Ethnicity"],
        race: json["Race"],
        latestHt: json["LatestHt"],
        latestWt: json["LatestWt"],
        latestBmi: json["LatestBmi"]?.toDouble(),
        surgHistDate: DateTime.parse(json["SurgHistDate"] ?? DateTime.now().toString()),
        surgHistProc: json["SurgHistProc"],
        famHistProb: json["FamHistProb"],
        whtSYrLvlFLchlCnsmptn: json["WhtSYrLvlFLchlCnsmptn"],
        dyrHvYVrSmkdTbcc: json["DYRHvYVrSmkdTbcc"],
        hwMnyChldrnDyHv: json["HwMnyChldrnDYHv"],
        covidPositive: json["CovidPositive"],
    );

    Map<String, dynamic> toJson() => {
        "Patientid": patientid,
        "PatientAge": patientAge,
        "PatGender": patGender,
        "Ethnicity": ethnicity,
        "Race": race,
        "LatestHt": latestHt,
        "LatestWt": latestWt,
        "LatestBmi": latestBmi,
        "SurgHistDate": surgHistDate.toIso8601String(),
        "SurgHistProc": surgHistProc,
        "FamHistProb": famHistProb,
        "WhtSYrLvlFLchlCnsmptn": whtSYrLvlFLchlCnsmptn,
        "DYRHvYVrSmkdTbcc": dyrHvYVrSmkdTbcc,
        "HwMnyChldrnDYHv": hwMnyChldrnDyHv,
        "CovidPositive": covidPositive,
    };
}


StateList stateListFromJson(String str) => StateList.fromJson(json.decode(str));

String stateListToJson(StateList data) => json.encode(data.toJson());

class StateList {
    List<Datum> data;

    StateList({
        required this.data,
    });

    factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String stateName;
    String? stateCode;
    String? abbreviation;

    Datum({
        required this.id,
        required this.stateName,
        required this.stateCode,
        required this.abbreviation,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["Id"],
        stateName: json["StateName"],
        stateCode: json["StateCode"],
        abbreviation: json["Abbreviation"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "StateName": stateName,
        "StateCode": stateCode,
        "Abbreviation": abbreviation,
    };
}


// To parse this JSON data, do
//
//     final insuranceList = insuranceListFromJson(jsonString);


List<InsuranceList> insuranceListFromJson(String str) => List<InsuranceList>.from(json.decode(str).map((x) => InsuranceList.fromJson(x)));

String insuranceListToJson(List<InsuranceList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InsuranceList {
    int id;
    int payerId;
    String insurancePrimaryName;
    int cpid;

    InsuranceList({
        required this.id,
        required this.payerId,
        required this.insurancePrimaryName,
        required this.cpid,
    });

    factory InsuranceList.fromJson(Map<String, dynamic> json) => InsuranceList(
        id: json["Id"],
        payerId: json["PayerId"],
        insurancePrimaryName: json["InsurancePrimaryName"],
        cpid: json["Cpid"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "PayerId": payerId,
        "InsurancePrimaryName": insurancePrimaryName,
        "Cpid": cpid,
    };
}
