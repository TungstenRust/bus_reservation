import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getFormattedDate(DateTime dt, {String pattern = 'dd/MM/yyyy'}){
  return DateFormat(pattern).format(dt);
}

void showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));

int getGrandTotal(int discount, int totalSeatBooked, int price, int fee){
  final subTotal = totalSeatBooked * price;
  final priceAfterDiscount = subTotal - ((subTotal * discount)/100);
  return (priceAfterDiscount + fee).toInt();
}

Future<bool> saveToken(String token) async{
  final preference= await SharedPreferences.getInstance();
  return preference.setString(accessToken, token);
}

Future<String> getToken() async{
  final preference = await SharedPreferences.getInstance();
  return preference.getString(accessToken) ?? '';
}

Future<bool> saveLoginTime(int time) async{
  final preference = await SharedPreferences.getInstance();
  return preference.setInt(loginTime, time);
}

Future<int> getLoginTime() async{
  final preference = await SharedPreferences.getInstance();
  return preference.getInt(loginTime) ?? 0;
}

Future<bool> saveExpirationDuration(int duration) async{
  final preference = await SharedPreferences.getInstance();
  return preference.setInt(expirationDuration, duration);
}

Future<int> getExpirationDuration() async{
  final preference = await SharedPreferences.getInstance();
  return preference.getInt(expirationDuration) ?? 0;
}

Future<bool> hasTokenExpired() async{
  final loginTime = await getLoginTime();
  final expDuration = await getExpirationDuration();
  return DateTime.now().millisecondsSinceEpoch - loginTime > expDuration;
}
