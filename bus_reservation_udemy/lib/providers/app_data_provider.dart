import 'package:bus_reservation_udemy/datasource/data_source.dart';
import 'package:bus_reservation_udemy/datasource/dummy_data_source.dart';
import 'package:flutter/cupertino.dart';

import '../models/bus_route.dart';

class AppDataProvider extends ChangeNotifier{
  final DataSource _dataSource = DummyDataSource();
  Future<BusRoute?> getRouteByCityFromAndCityTo(String cityFrom, String cityTo){
    return _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }
}