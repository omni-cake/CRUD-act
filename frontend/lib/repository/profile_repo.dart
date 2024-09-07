import "dart:convert";
import "package:frontend/models/studentProfiles.dart";
import "package:http/http.dart" as http;

abstract class ProfileRepo {
  Future<List<StudentProfile>> fetchProfiles();
  Future<void> createProfile(StudentProfile studentProfile);
  Future<void> deleteProfile(String id);
  Future<void> updateProfile(String id, StudentProfile studentProfile);
}

class ProfileRepoImplement implements ProfileRepo {
  static const String baseUrl = "http://192.168.100.134:5000/profiles";

  @override
  Future<List<StudentProfile>> fetchProfiles() async {
    // TODO: implement fetchProfiles
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => StudentProfile.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load students");
    }
  }

  @override
  Future<void> createProfile(StudentProfile studentProfile) async {
    // TODO: implement createProfile
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(studentProfile.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to create profile for student");
    }
  }

  @override
  Future<void> deleteProfile(String id) async {
    print("Deleting profile with ID: $id"); // Add this line to check
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception("Failed to delete student profile");
    }
  }

  @override
  Future<void> updateProfile(String id, StudentProfile studentProfile) async {
    // TODO: implement updateProfile
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(studentProfile.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update student');
    }
  }
}
