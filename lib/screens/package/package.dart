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
import '../../provider/package.dart';
import '../summary/summary.dart';

class PackagePage extends StatefulWidget {
  const PackagePage({
    super.key,
    this.name,
    this.speciality,
    this.image,
    this.location,
    this.day,
    this.mon,
    this.tim,
    this.year,
    this.doctor
  });
  final name, speciality, image, location, day, mon, tim, year, doctor;

  @override
  State<PackagePage> createState() => _PackagePageState();
}

enum Item { msg, voice, video, person }

class _PackagePageState extends State<PackagePage> {
  late Item _pack = Item.msg;
  int selectedValue = 0, cnt = 1;
  List<dynamic> packages = [], duration = [];
  Map<String, dynamic> serviceOption = {};
  String finalPack = " ", finalDuration = '';
  List<String> talk = [
    "Chat with Doctor",
    "Voice Call with Doctor",
    "Video Call with Doctor",
    "In person with doctor"
  ];
  List<IconData> icon = [
    Icons.messenger,
    Icons.phone,
    Icons.video_call,
    Icons.person
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
    final response = await http.get(Uri.parse('${Config.packageUrl}'));
    if (response.statusCode == 200) {
      setState(() {
        serviceOption = jsonDecode(response.body);

        finalDuration = serviceOption['duration'][0].toString();
        finalPack = serviceOption['package'][0].toString();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  bool selected = true, isLoading = true;
  int index = 1;
  String selectedValued = '30';
  List<String> durationOptions = [];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ServiceOptionsProvider>(context);

    if (serviceOption.isNotEmpty && cnt == 1) {
      durationOptions = serviceOption['duration'].cast<String>();
      selectedValued =
          durationOptions.isNotEmpty ? durationOptions.first : '30';
      cnt++;
    }
    return Scaffold(
        appBar: customAppBar('Select Package', context, true),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Duration',
                    style: TextStyle(
                        color: kGrey1,
                        fontSize: headerFontSize,
                        fontWeight: FontWeight.w600)),
                const BigGap(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: kGrey5),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.alarm,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(width: 4),
                      DropdownButton<String>(
                          value: selectedValued,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValued = newValue!;
                              finalDuration = newValue;
                            });
                          },
                          items: durationOptions
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color:
                                kPrimaryColor, // Change to your desired color
                          ),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                const BigGap(),
                const Text('Select Package',
                    style: TextStyle(
                        color: kGrey1,
                        fontSize: headerFontSize,
                        fontWeight: FontWeight.w600)),
                const NormalGap(),
                serviceOption.isNotEmpty
                    ? displayPackageList()
                    : const SizedBox(),
                // const Spacer(),

                appointmentButton(context),
                OpacityWidget(isLoading: isLoading),
              ]),
        ));
  }

  Expanded displayPackageList() {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => Container(height: 8),
          itemCount: serviceOption['package'].length,
          itemBuilder: (context, index) {
            final package = serviceOption['package'][index];

            return Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: kTextFieldColor,
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: packageCard(package, index),
            );
          }),
    );
  }

  Card packageCard(package, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: kBadgeBlue,
                      borderRadius: BorderRadius.circular(28)),
                  child: Icon(
                    icon[index],
                    color: kPrimaryColor,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 6),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          color: kGrey2,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      talk[index],
                      style: const TextStyle(
                          fontSize: 12,
                          color: kGrey3,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Radio(
              fillColor:
                  MaterialStateColor.resolveWith((states) => kPrimaryColor),
              focusColor:
                  MaterialStateColor.resolveWith((states) => Colors.grey),
              value: index,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                  finalPack = package;
                });
              },
            )
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
          // Navigator.pop(context);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => SummaryPage(
                      name: widget.name,
                      speciality: widget.speciality,
                      image: widget.image,
                      location: widget.location,
                      day: widget.day,
                      mon: widget.mon,
                      tim: widget.tim,
                      year: widget.year,
                      duration: finalDuration,
                      package: finalPack,
                      doctor: widget.doctor,)),
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
}
