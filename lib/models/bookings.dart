class Appointment {
  final String bookingId;
  final String doctorName;
  final String location;
  final String appointmentDate;
  final String appointmentTime;

  Appointment({
    required this.bookingId,
    required this.doctorName,
    required this.location,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      bookingId: json['booking_id'],
      doctorName: json['doctor_name'],
      location: json['location'],
      appointmentDate: json['appointment_date'],
      appointmentTime: json['appointment_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'doctor_name': doctorName,
      'location': location,
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
    };
  }
}
