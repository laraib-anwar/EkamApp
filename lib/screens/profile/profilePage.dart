import 'package:ekam/components/bigGap.dart';
import 'package:ekam/components/midGap.dart';
import 'package:ekam/components/normalGap.dart';
import 'package:ekam/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../models/doctor.dart';
import '../package/package.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.doctor});

  final dynamic doctor;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool selected = true, selectedTime = true;
  int ind = 0, tind = 0, timeIndex = 0;
  List<String> date = [], days = [], time = [], months = [], dayNum = [];
  List<String> datesWithAvailableSlots = [];
  List<List<dynamic>> timeSlots = [];
  List<List<String>> timeSlotsFinal = [];
  List<int> lnt = [];
  List<List<String>> result = [];
  int currentIndex = 0, count = 0;
  String day = '', mon = '', tim = '', year = '';

  @override
  void initState() {
    super.initState();
    getAvailableDates(widget.doctor['availability']);
    String firstKey = widget.doctor['availability'].keys.first;
    List<dynamic> firstValue = widget.doctor['availability'][firstKey];
    String f = firstValue[0].toString().substring(0, 8);
    DateTime date = DateTime.parse(firstKey);
    day = date.day.toString();
    year = date.year.toString();
    mon = DateFormat.MMMM().format(date);
    tim = f;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Doctors List', context, true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              doctorProfile(),
              const NormalGap(),
              const Divider(),
              const NormalGap(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  doctorSpecific(
                    Icons.person,
                    'Patients',
                    widget.doctor['patients_served'].toString(),
                  ),
                  doctorSpecific(
                    Icons.card_travel,
                    'Years Exp.',
                    widget.doctor['years_of_experience'].toString(),
                  ),
                  doctorSpecific(
                    Icons.star_half,
                    'Rating',
                    widget.doctor['rating'].toString(),
                  ),
                  doctorSpecific(
                    Icons.messenger,
                    'Review',
                    widget.doctor['number_of_reviews'].toString(),
                  ),
                ],
              ),
              const BigGap(),
              const Text('BOOK APPOINTMENT',
                  style: TextStyle(color: kGrey5, fontSize: 14)),
              const BigGap(),
              const Text(
                'Day',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: headerFontSize,
                    fontWeight: FontWeight.w500),
              ),
              const BigGap(),
              daySlotsTab(),
              const BigGap(),
              const Text(
                'Time',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: headerFontSize,
                    fontWeight: FontWeight.w500),
              ),
              const BigGap(),
              timeSlotsTab(),
              const BigGap(),
              const BigGap(),
              const BigGap(),
              appointmentButton(context),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox daySlotsTab() {
    return SizedBox(
      height: 70,
      width: 700,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: datesWithAvailableSlots.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected = true;
                    ind = index;
                    timeIndex = index;
                    day = dayNum[index];
                    mon = months[index];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: (25),
                    vertical: (10),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: kGrey6),
                    color: selected == true && index == ind
                        ? kPrimaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      Text(
                        days[index],
                        style: TextStyle(
                            color: selected == true && index == ind
                                ? Colors.white
                                : kGrey3,
                            fontSize: 14),
                      ),
                      Text(
                        '${dayNum[index]} ${months[index].substring(0, 3)}',
                        style: TextStyle(
                            color: selected == true && index == ind
                                ? Colors.white
                                : kGrey3,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12)
            ],
          );
        },
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
          // Navigator.pop(context);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => PackagePage(
                        name: widget.doctor['doctor_name'],
                        speciality: widget.doctor['speciality'],
                        image: widget.doctor['image'],
                        location: widget.doctor['location'],
                        day: day,
                        mon: mon,
                        tim: tim,
                        year: year,
                        doctor: widget.doctor,
                      )),
              (route) => true);
        },
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Make Appointment',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  SizedBox timeSlotsTab() {
    return SizedBox(
      height: 40,
      width: 700,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: result[timeIndex].length,
        itemBuilder: (BuildContext context, int indTime) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTime = true;
                    tind = indTime;
                    tim = result[timeIndex][indTime];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: (10),
                    vertical: (10),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: kGrey6),
                    color: selectedTime == true && indTime == tind
                        ? kPrimaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      Text(
                        result[timeIndex][indTime],
                        style: TextStyle(
                            color: selectedTime == true && indTime == tind
                                ? Colors.white
                                : kGrey3,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12)
            ],
          );
        },
      ),
    );
  }

  Row doctorProfile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          ClipOval(
              child: Image.network(
            widget.doctor['image'],
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
        Text(widget.doctor['doctor_name'],
            style: const TextStyle(
                color: kGrey1,
                fontSize: headerFontSize,
                fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 4,
        ),
        Text(widget.doctor['speciality'],
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
            Text(widget.doctor['location'],
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

  Column doctorSpecific(dynamic icon, String heading, String subheading) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: kBadgeBlue, borderRadius: BorderRadius.circular(28)),
          child: Icon(
            icon,
            color: kPrimaryColor,
            size: 30,
          ),
        ),
        const NormalGap(),
        Text(
          '$subheading+',
          style: const TextStyle(
              color: kPrimaryColor,
              fontSize: headerFontSize,
              fontWeight: FontWeight.w600),
        ),
        const MidGap(),
        Text(heading, style: const TextStyle(color: kGrey3, fontSize: 14))
      ],
    );
  }

  getDayMonth(List<String> dates) {
    for (int i = 0; i < dates.length; i++) {
      String dateStr = dates[i];
      DateTime date = DateTime.parse(dateStr);

      DateTime today = DateTime.now();

      bool isToday = date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;
      int dayNo = date.day;
      year = date.year.toString();

      String dayName =
          DateFormat.E().format(date); // Get the day name (e.g., Monday)
      String monthName = DateFormat.MMMM().format(date);
      days.add(isToday ? 'Today' : dayName);
      months.add(monthName);
      dayNum.add(dayNo.toString());
      timeSlots.add((widget.doctor['availability'][dateStr]));

      for (int i = 0; i < timeSlots.length; i++) {
        lnt.add(timeSlots[i].length);
        for (int j = 0; j < timeSlots[i].length; j++) {
          String timeSlot1 = timeSlots[i][j].toString();

          List<String> newTimeSlots = [];
          String tm1 = "", tm2 = "", fn = "", sn = "";
          int a = 0, b = 0;
          int ind1 = timeSlot1.indexOf(':');
          tm2 = timeSlot1.substring(timeSlot1.length - 2);
          int ind2 = timeSlot1.lastIndexOf(':');
          int ind3 = timeSlot1.lastIndexOf('-');
          int slotsLen = 0, switched = 0;
          if (ind2 - ind3 == 3 && ind1 == 2) {
            sn = timeSlot1.substring(ind2 - 1, 12);
          } else if (ind2 - ind3 == 4 && ind1 == 2) {
            sn = timeSlot1.substring(ind2 - 2, 13);
          }
          if (ind2 - ind3 == 3 && ind1 == 1) {
            sn = timeSlot1.substring(ind2 - 1, 11);
          } else if (ind2 - ind3 == 4 && ind1 == 1) {
            sn = timeSlot1.substring(ind2 - 2, 12);
          }
          if (ind1 == 1) {
            tm1 = timeSlot1.substring(5, 7);
            fn = timeSlot1.substring(0, 1);
          } else if (ind1 == 2) {
            tm1 = timeSlot1.substring(6, 8);
            fn = timeSlot1.substring(0, 2);
          }

          a = int.parse(fn);
          b = int.parse(sn);

          if (tm1 == tm2) {
            slotsLen = (b - a) + 1;
          } else if (tm1 != tm2) {
            slotsLen = b != 12 ? (12 + b - a) + 1 : (b - a) + 1;
          }

          for (int i = 1; i <= slotsLen; i++) {
            if (a - 12 == 0) {
              switched = 1;
            }
            if (switched != 1) {
              newTimeSlots.add('$a:00 $tm1');
              if (i != slotsLen) {
                newTimeSlots.add('$a:30 $tm1');
              }
            }

            if (switched == 1) {
              newTimeSlots
                  .add(a != 12 ? '${(a - 12).abs()}:00 $tm2' : '$a:00 $tm2');
              if (i != slotsLen) {
                newTimeSlots
                    .add(a != 12 ? '${(a - 12).abs()}:30 $tm2' : '$a:30 $tm2');
              }
            }
            a++;
          }
          timeSlotsFinal.add(newTimeSlots);
        }
      }

      // print(timeSlotsFinal);

      for (int i = 0; i < lnt.length; i++) {
        List<String> mergedList = [];
        for (int j = i; j < i + lnt[i]; j++) {
          if (currentIndex < timeSlotsFinal.length) {
            mergedList.addAll(timeSlotsFinal[currentIndex]);
          }
          currentIndex++;
        }
        result.add(mergedList);
      }
    }
  }

  void getAvailableDates(Map<String, dynamic> availability) {
    availability.forEach((date, slots) {
      if (slots.isNotEmpty) {
        datesWithAvailableSlots.add(date);
      }
    });
    getDayMonth(datesWithAvailableSlots);
  }
}
