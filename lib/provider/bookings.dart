import 'dart:async';

import 'package:ekam/models/bookings.dart';
import 'package:flutter/material.dart';
import '../../config.dart';
import '../models/doctor.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingsProvider with ChangeNotifier {
  BookingsProvider();
  Appointment? _doctors;

  Appointment? get doctors {
    return _doctors;
  }

  set doctors(Appointment? doctors) {
    _doctors = doctors;
    notifyListeners();
  }

  

  Future<void> getBookings() async {
    try {
      var response = await http.get(Uri.parse("${Config.bookingsUrl}"));
      print(response.body);
      if (response.statusCode == 200) {
        _doctors = Appointment.fromJson(response.body as Map<String, dynamic>);

        notifyListeners();
      }
    } catch (e) {
      // print(e.response.toString());
    }
  }
}
