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
import 'package:intl/intl.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({
    super.key,
  });

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  List<dynamic> doctors = [];
  List<String> month = [],
      day = [],
      time = [],
      year = [],
      images = [
        'https://hireforekam.s3.ap-south-1.amazonaws.com/doctors/1-Doctor.png',
        'https://hireforekam.s3.ap-south-1.amazonaws.com/doctors/2-Doctor.png',
        'https://hireforekam.s3.ap-south-1.amazonaws.com/doctors/3-Doctor.png',
        'https://hireforekam.s3.ap-south-1.amazonaws.com/doctors/4-Doctor.png'
      ];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse('${Config.bookingsUrl}'));
    if (response.statusCode == 200) {
      setState(() {
        doctors = jsonDecode(response.body);
        print(doctors);
        for (int i = 0; i < doctors.length; i++) {
          DateTime date = DateTime.parse(doctors[i]['appointment_date']);

          String dayNo = date.day.toString();
          String yr = date.year.toString();

          String monthName = DateFormat.MMMM().format(date).substring(0, 3);
          String tim =
              doctors[i]['appointment_time'].toString().substring(0, 8);
          day.add(dayNo);
          year.add(yr);
          month.add(monthName);
          time.add(tim);
        }
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
      appBar: customAppBar('My bookings', context, true),
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
              child: doctorCard(doctor, index));
        });
  }

  Card doctorCard(doctor, index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${month[index]} ${day[index]} , ${time[index]}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
            const NormalGap(),
            const Divider(),
            const NormalGap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                       
                        borderRadius: BorderRadius.circular(12)),
                    child: Image.network(images[index])),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        doctor['doctor_name'],
                        style: const TextStyle(
                            fontSize: 14,
                            color: kGrey2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const NormalGap(),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: kGrey3,
                        ),
                        Text(
                          doctor['location'],
                          style: const TextStyle(
                              fontSize: 14,
                              color: kGrey5,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const NormalGap(),
                    Row(
                      children: [
                        const Icon(
                          Icons.book_online,
                          color: kGrey3,
                        ),
                        Text(
                          'Booking ID: ${doctor['booking_id']}',
                          style: const TextStyle(
                              fontSize: 14,
                              color: kGrey5,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const NormalGap(),
            const Divider(),
            const NormalGap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: (35),
                      vertical: (14),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      // border: Border()
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16))),
                const SizedBox(
                  width: 8,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: (35),
                      vertical: (14),
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                      // border: Border.all()
                    ),
                    child: const Text('Reschedule',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
