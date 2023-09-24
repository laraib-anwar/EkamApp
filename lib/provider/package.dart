import 'dart:async';

import 'package:flutter/material.dart';
import '../../config.dart';
import '../models/doctor.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceOptionsProvider with ChangeNotifier {
  ServiceOptionsProvider();
  Doctor? _doctors;

  Doctor? get doctors {
    return _doctors;
  }

  set doctors(Doctor? doctors) {
    _doctors = doctors;
    notifyListeners();
  }

  Future<void> getDoctors() async {
    try {
      var response = await http.get(Uri.parse("${Config.url}"));
      print(response.body);
      if (response.statusCode == 200) {
        _doctors = Doctor.fromJson(response.body as Map<String, dynamic>);

        notifyListeners();
      }
    } catch (e) {
      // print(e.response.toString());
    }
  }
}
