import "package:equatable/equatable.dart";

class StudentProfile extends Equatable {
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
        id: json["id"] as String,
        firstName: json["firstName"] as String,
        lastName: json["lastName"] as String,
        course: json["course"] as String,
        year: json["year"] as String,
        enrolled: json["enrolled"] as bool);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "course": course,
      "year": year,
      "enrolled": enrolled,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, firstName, lastName, course, year, enrolled];
}
