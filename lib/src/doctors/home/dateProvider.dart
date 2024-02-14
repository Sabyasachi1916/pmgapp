import 'package:flutter/foundation.dart';
import 'package:pmgapp/src/doctors/home/home_model.dart';
import 'package:pmgapp/src/doctors/home/home_service.dart';

class DateProvider extends ChangeNotifier{
  DateTime selectedDate = DateTime.now();
  void setDate(date){
    selectedDate = date;
    getData(selectedDate);
    notifyListeners();
  }
  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
  FollowUpList? followUpList;

  void getData(DateTime date){
    DateTime today = getDate( date);
    homeService()
        .getDailyLeads('${today.year}-${today.month}-${today.day}')
        .then((value) => {
                  followUpList = value,
                  notifyListeners()
            });
  }
}