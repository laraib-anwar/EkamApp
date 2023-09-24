import 'dart:convert';
import 'package:ekam/screens/profile/profilePage.dart';
import 'package:http/http.dart' as http;

import 'package:ekam/components/bigGap.dart';
import 'package:ekam/components/midGap.dart';
import 'package:ekam/components/normalGap.dart';
import 'package:ekam/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../components/opacity.dart';
import '../../config.dart';
import '../../models/doctor.dart';
import '../../provider/doctors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> doctors = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse('${Config.url}'));
    if (response.statusCode == 200) {
      setState(() {
        doctors = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  bool selected = true, isLoading = true;
  int index = 1;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DoctorsProvider>(context);

    return Scaffold(
      appBar: customAppBar('Doctors List', context, false),
      body: Stack(children: [
        displayDoctorsList(),
        OpacityWidget(isLoading: isLoading),
      ]),
    );
  }

  ListView displayDoctorsList() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) => Container(height: 8),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];

          return Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: kTextFieldColor,
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(doctor: doctor)),
                      (route) => true);
                },
                child: doctorCard(doctor),
              ));
        });
  }

  Card doctorCard(doctor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor['doctor_name'],
                  style: const TextStyle(
                      fontSize: 14, color: kGrey2, fontWeight: FontWeight.bold),
                ),
                Text(
                  doctor['speciality'],
                  style: const TextStyle(
                      fontSize: 12, color: kGrey3, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: kBadgeOrange,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Image.network(doctor['image'])),
          ],
        ),
      ),
    );
  }
}
