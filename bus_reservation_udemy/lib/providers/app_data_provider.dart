import 'package:bus_reservation_udemy/datasource/data_source.dart';
import 'package:bus_reservation_udemy/datasource/dummy_data_source.dart';
import 'package:bus_reservation_udemy/models/reservation_expansion_item.dart';
import 'package:bus_reservation_udemy/models/response_model.dart';
import 'package:flutter/material.dart';

import '../models/bus_reservation.dart';
import '../models/bus_route.dart';
import '../models/bus_schedule.dart';

class AppDataProvider extends ChangeNotifier {
  List<Bus> _busList = [];
  List<Bus> get busList => _busList;
  List<BusRoute> _routeList = [];
  List<BusRoute> get routeList => _routeList;
  List<BusSchedule> _scheduleList = [];
  List<BusSchedule> get scheduleList => _scheduleList;
  List<BusReservation> _reservationList = [];
  List<BusReservation> get reservatinList => _reservationList;
  final DataSource _dataSource = DummyDataSource();

  Future<ResponseModel>addReservation(BusReservation reservation){
    return _dataSource.addReservation(reservation);
  }

  Future <void> getAllReservations()async{
    _reservationList = await _dataSource.getAllReservation();
    notifyListeners();
  }

  Future<BusRoute?> getRouteByCityFromAndCityTo(String cityFrom,
      String cityTo) {
    return _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    return _dataSource.getSchedulesByRouteName(routeName);
  }
  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(int scheduleId, String departureDate){
    return _dataSource.getReservationsByScheduleAndDepartureDate(scheduleId, departureDate);
  }
  List<ReservationExpansionItem> getExpansionItems(){
    return List.generate(_reservationList.length, (index){
      final reservation = _reservationList[index];
      return ReservationExpansionItem(
          header: ReservationExpansionHeader(
            reservationId: reservation.reservationId,
            departureDate: reservation.departureDate,
            schedule: reservation.busSchedule,
            timestamp: reservation.timestamp,
            reservationStatus: reservation.reservationStatus,
          ),
          body: ReservationExpansionBody(
              customer: reservation.customer,
              totalSeatedBooked: reservation.totalSeatBooked,
              seatNumbers: reservation.seatNumbers,
              totalPrice: reservation.totalPrice,
          ),
      );
    });
  }
}