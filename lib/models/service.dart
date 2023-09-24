class ServiceOptions {
  List<String> duration;
  List<String> package;

  ServiceOptions({
    required this.duration,
    required this.package,
  });

  factory ServiceOptions.fromJson(Map<String, dynamic> json) {
    return ServiceOptions(
      duration: List<String>.from(json['duration']),
      package: List<String>.from(json['package']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
      'package': package,
    };
  }
}
