import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kPrimaryColor = Color.fromARGB(255, 20, 74, 236);

const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const k1 = Color(0xFF84235D);
const k2 = Color(0xFFB22178);
const kButtonColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF84235D), Color(0xFFB22178)],
);
const kSecondaryColor = Color(0xFFff5f1b);
const kTextFieldColor = Color(0xFFededed);
const kTextColor = Color(0xFF757575);

const kBadgeOrange = Color(0xFFffe5d1);
const kBadgeBlue = Color(0xFFe1eaff);
const kBadgeGreen = Color(0xFFcefecd);
const kDivider = Color(0xFFc4c4c4);

const kSmallText = Color(0xFF4b4b4b);
const kGrey1 = Color(0xFF1b1b1b);
const kGrey2 = Color(0xFF4b4b4b);
const kGrey3 = Color(0xFF7a7a7a);
const kGrey5 = Color(0xFFb3b3b3);
const kGrey6 = Color(0xFFededed);

const kSwitch = Color(0xFF08A605);

const kTextTabColor = Color(0xFF7a7a7a);
const kIconBackColor = Color(0xFF1b1b1b);

const kShadow = Color.fromRGBO(0, 0, 0, 0.05);

const double headerFontSize = 20;

const kAnimationDuration = Duration(milliseconds: 200);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kOtpSuccess =
    "Note: The 5 digit OTP was successfully sent to your phone number.Please enter the correct OTP";
const String kOtpEnter = 'Enter your OTP';
const String kPhoneLengthError = 'Phone length must have length of 10 digits';
const String kShortPassError = "Password is too short";
const String kMatchOtpError = "Otp did not match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberError = 'Phone number does not exist';
const String kOtpError = "Otp must be five characters";
const String kOrdersMsg = "There are no new orders at this moment";


AppBar customAppBar(String title, context, bool isLead) {
  return AppBar(
    bottomOpacity: 0,
    shadowColor: Colors.white,
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ),
    leading: isLead ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: 64,
          // width:64,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey)),
          child: IconButton(
              icon:
                  const Icon(Icons.arrow_back, color: kIconBackColor, size: 20),
              onPressed: () => Navigator.of(context).pop()),
        ),
      ),
    ): null,
    title: Center(
      child: Text(
        title,
        style: const TextStyle(color: kGrey2, fontSize: headerFontSize),
      ),
    ),
  );
}
