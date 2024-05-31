import 'package:bus_reservation_udemy/models/bus_reservation.dart';
import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/models/customer.dart';
import 'package:bus_reservation_udemy/providers/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingConfirmationPage extends StatefulWidget {
  const BookingConfirmationPage({super.key});

  @override
  State<BookingConfirmationPage> createState() => _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  late BusSchedule schedule;
  late String departureDate;
  late int totalSeatsBooked;
  late String seatNumbers;
  bool isFirst = true;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    nameController.text = 'Mr. ABC';
    mobileController.text = '0123452433';
    emailController.text = 'abc@gmail.com';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(isFirst){
      final argList = ModalRoute.of(context)!.settings.arguments as List;
      departureDate = argList[0];
      schedule = argList[1];
      seatNumbers = argList[2];
      totalSeatsBooked = argList[3];
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Booking'),),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Please provide your information',
                style: TextStyle(fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Customer Name',
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {

                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Mobile Number',
                  filled: true,
                  prefixIcon: const Icon(Icons.call),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {

                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  filled: true,
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {

                  });
                },
              ),
            ),
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Booking Summery', style: TextStyle(fontSize: 16),),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Customer Name: ${nameController.text}'),
                    Text('Mobile Number: ${mobileController.text}'),
                    Text('Email Address: ${emailController.text}'),
                    Text('Route: ${schedule.busRoute.routeName}'),
                    Text('Departure Date: $departureDate'),
                    Text('Departure Time: ${schedule.departureTime}'),
                    Text('Ticket Price: $currency${schedule.ticketPrice}'),
                    Text('Total Seat(s): $totalSeatsBooked'),
                    Text('Seat Number(s): $seatNumbers'),
                    Text('Discount: ${schedule.discount}%'),
                    Text('Processing Fee: ${schedule.processingFee}%'),
                    Text('Grand Total: $currency${getGrandTotal(
                        schedule.discount, totalSeatsBooked,
                        schedule.ticketPrice, schedule.processingFee)}%',
                      style: TextStyle(fontSize: 18,),)
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _confirmBooking,
              child: const Text('CONFIRM BOOKING'),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }
  void _confirmBooking(){
    if(_formKey.currentState!.validate()){
      final customer = Customer(
          customerName: nameController.text,
          mobile: mobileController.text,
          email: emailController.text,
      );
      final reservation = BusReservation(
          customer: customer,
          busSchedule: schedule,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          departureDate: departureDate,
          totalSeatBooked: totalSeatsBooked,
          seatNumbers: seatNumbers,
          reservationStatus: reservationActive,
          totalPrice: getGrandTotal( schedule.discount, totalSeatsBooked,
              schedule.ticketPrice, schedule.processingFee)
      );
      Provider.of<AppDataProvider>(context, listen:false)
      .addReservation(reservation)
      .then((response){
        if(response.responseStatus == ResponseStatus.SAVED){
          showMsg(context, response.message);
          Navigator.popUntil(context, ModalRoute.withName(routeNameHome));
        }else{
          showMsg(context, response.message);
        }
      })
      .catchError((error){
        showMsg(context, 'Could not save');
      });
    }
  }
}
