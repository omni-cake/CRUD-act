class StudentProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  StudentProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      id: json['_id'] ?? '', // Ensure the ID is set from the backend response
      firstName: json['firstName'],
      lastName: json['lastName'],
      course: json['course'],
      year: json['year'],
      enrolled: json['enrolled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'course': course,
      'year': year,
      'enrolled': enrolled,
    };
  }
}
