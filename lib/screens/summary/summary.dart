import 'package:ekam/screens/Confirm/confirm.dart';
import 'package:ekam/screens/profile/profilePage.dart';

import 'package:ekam/components/bigGap.dart';
import 'package:ekam/components/midGap.dart';
import 'package:ekam/components/normalGap.dart';
import 'package:ekam/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage(
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
      required this.package,
      required this.doctor});
  final name,
      speciality,
      image,
      location,
      day,
      mon,
      tim,
      year,
      duration,
      package,
      doctor;
  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  void initState() {
    print(widget.duration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar('Review Summary', context, true),
        body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    doctorProfile(),
                    const NormalGap(),
                    const Divider(),
                    const NormalGap(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Date & hour',
                              style: TextStyle(
                                  color: kGrey3,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                                '${widget.mon} ${widget.day} | ${widget.tim}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        const NormalGap(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Package',
                                style: TextStyle(
                                    color: kGrey3,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            Text('${widget.package}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        const NormalGap(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Duration',
                                style: TextStyle(
                                    color: kGrey3,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            Text('${widget.duration} minutes',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        const NormalGap(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Booking for',
                                style: TextStyle(
                                    color: kGrey3,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            Text('self',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        const NormalGap(),

                    editButton(context)

                      ],
                    ),
                  const Spacer(),
                    appointmentButton(context)
                  ]),
            )));
  }

  Row doctorProfile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          ClipOval(
              child: Image.network(
            widget.image,
            height: 89,
            width: 89,
          )),
          const Positioned(
              right: -2,
              bottom: 20,
              child: Icon(
                Icons.check_circle,
                color: kPrimaryColor,
              ))
        ]),
        const SizedBox(
          width: 20,
        ),
        doctorProfileSection(),
      ],
    );
  }

  Column doctorProfileSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.name,
            style: const TextStyle(
                color: kGrey1,
                fontSize: headerFontSize,
                fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 4,
        ),
        Text(widget.speciality,
            style: const TextStyle(color: kGrey3, fontSize: 14)),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: kPrimaryColor,
            ),
            Text(widget.location,
                style: const TextStyle(
                    color: kGrey3, fontSize: 14, fontWeight: FontWeight.w600)),
            const Icon(
              Icons.flag_outlined,
              color: kPrimaryColor,
            )
          ],
        ),
      ],
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
              MaterialPageRoute(builder: (context) => ConfirmPage(name: widget.name,speciality: widget.speciality, image:widget.image,
              location: widget.location, day: widget.day, mon: widget.mon, tim: widget.tim, year: widget.year,  duration: widget.duration,
              package: widget.package,
              )),
              (route) => true);
        },
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Next',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  SizedBox editButton(BuildContext context) {
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
              MaterialPageRoute(
                  builder: (context) => ProfilePage(
                       doctor: widget.doctor,
                      )),
              (route) => true);
        },
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Edit',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
