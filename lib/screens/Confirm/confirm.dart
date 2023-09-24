import 'package:ekam/screens/profile/profilePage.dart';

import 'package:ekam/components/bigGap.dart';
import 'package:ekam/components/midGap.dart';
import 'package:ekam/components/normalGap.dart';
import 'package:ekam/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bookings/bookings.dart';
import '../home/homePage.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage(
      {super.key,
      required this.name,
      required this.speciality,
      required this.image,
      required this.location,
      required this.day,
      required this.mon,
      required this.tim,
      required this.year,
      required this.duration,
      required this.package});
  final name,
      speciality,
      image,
      location,
      day,
      mon,
      tim,
      year,
      duration,
      package;
  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Confirmation', context, true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween, // Add this line
          children: [
            const Center(
              child: Icon(Icons.check_circle, color: kPrimaryColor, size: 120),
            ),
            const BigGap(),
            const Text(
              'Appointment Confirmed!',
              style: TextStyle(
                  color: kGrey1,
                  fontSize: headerFontSize,
                  fontWeight: FontWeight.w600),
            ),
            const BigGap(),
            const Text(
              'You have successfully booked appointment with',
              style: TextStyle(
                  color: kGrey3, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            const NormalGap(),
            Text(
              '${widget.name}',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            const BigGap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
                Text(
                  'Esther Howard',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const BigGap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: kPrimaryColor,
                    ),
                    Text(
                      '${widget.day} ${widget.mon.toString().substring(0, 3)} , ${widget.year}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.alarm,
                      color: kPrimaryColor,
                    ),
                    Text(
                      '${widget.tim}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            appointmentButton(context),
            const NormalGap(),
            InkWell(
              onTap: () {
                 Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage(title: 'Doctors List',)),
                    (route) => true);
              },
              child: const Text(
                'Book Another',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox appointmentButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          )),
          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BookingsPage()),
              (route) => true);
        },
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'View Appointments',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
