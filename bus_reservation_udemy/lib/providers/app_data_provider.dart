import 'package:bus_reservation_udemy/datasource/data_source.dart';
import 'package:bus_reservation_udemy/datasource/dummy_data_source.dart';
import 'package:flutter/cupertino.dart';

import '../models/bus_route.dart';
import '../models/bus_schedule.dart';

class AppDataProvider extends ChangeNotifier{
  List<BusSchedule> _scheduleList = [];
  List<BusSchedule> get scheduleList => _scheduleList;
  final DataSource _dataSource = DummyDataSource();
  Future<BusRoute?> getRouteByCityFromAndCityTo(String cityFrom, String cityTo){
    return _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }
}

void getSchedulesByRouteName(String routeName) async{
  _scheduleList = await _dataSource.getSchedulesByRouteName(routeName);
  notifyListeners();
}