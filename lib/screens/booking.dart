import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:turf_scout/components/button.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<TimeOfDay> _bookedTimeslots = [];

  Future<void> _fetchBookedTimeslots(String date) async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/bookings?date=$date'));
    if (response.statusCode == 200) {
      final bookedTimeslots = List<TimeOfDay>.from(
        json.decode(response.body).map((slot) =>
            TimeOfDay.fromDateTime(DateTime.parse(slot['booking_time']))),
      );
      setState(() {
        _bookedTimeslots = bookedTimeslots;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.body}')),
      );
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker( 
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _bookedTimeslots.clear();
      });
      _fetchBookedTimeslots(picked.toString().split(" ")[0]);
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final pickedDateTime =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      final allowedTimeSlotStart = DateTime.now();
      final allowedTimeSlotEnd = DateTime.now().add(const Duration(hours: 2));

      if (pickedDateTime.isAfter(allowedTimeSlotStart) &&
          pickedDateTime.isBefore(allowedTimeSlotEnd)) {
        if (!_bookedTimeslots.contains(picked)) {
          setState(() {
            _selectedTime = picked;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('This time slot is already booked.', style: TextStyle(color: Color(0xff97FB57)),)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Booking time must be within a 2-hour time slot from the current time.', style: TextStyle(color: Color(0xff97FB57)),)),
        );
      }
    }
  }

  final _formKey = GlobalKey<FormState>();

  late String _userId, _turfId, _duration, _totalPrice, _bookingStatus;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedTime != null) {
      _formKey.currentState!.save();

      final bookingDateTime = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute);

      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/booking'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "user_id": _userId,
          "turf_id": _turfId,
          "duration": _duration,
          "total_price": _totalPrice,
          "booking_status": _bookingStatus,
          "booking_time": bookingDateTime.toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking Successful', style: TextStyle(color: Color(0xff97FB57)),)),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body},', style: const TextStyle(color: Color(0xff97FB57)),)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: const Color(0xff121212),
        title: const Text('Book Turf',
            style: TextStyle(
                color: Color(0xff97FB57), fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: const Color(0xff121212),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                Expanded(
                  child: TextFormField(
                    controller: TextEditingController(
                      text: _selectedDate?.toString().split(" ")[0] ?? '',
                    ),
                    readOnly: true,
                    onTap: _selectDate,
                    decoration: const InputDecoration(
                      hintText: "Select Date",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff97FB57))),
                      filled: true,
                      fillColor: Colors.black,
                      labelText: "Date",
                      labelStyle: TextStyle(color: Color(0xff97FB57)),
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: Color(0xff97FB57),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    controller: TextEditingController(
                      text: _selectedTime?.format(context) ?? '',
                    ),
                    readOnly: true,
                    onTap: _selectTime,
                    decoration: const InputDecoration(
                      hintText: "Select Time",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff97FB57))),
                      filled: true,
                      fillColor: Colors.black,
                      labelText: "Time",
                      labelStyle: TextStyle(color: Color(0xff97FB57)),
                      prefixIcon: Icon(
                        Icons.access_time,
                        color: Color(0xff97FB57),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                MyButton(text: 'Pay', onTap: _submitForm)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
