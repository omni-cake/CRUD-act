import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/models/studentProfileCard.dart';
import 'package:frontend/models/studentProfiles.dart';
import '../blocs/profile_bloc.dart';
import '../blocs/profile_event.dart';
import '../blocs/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedYear = 'First Year';
  bool _isEnrolled = false;
  final List<String> _yearOptions = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
    'Fifth Year',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        centerTitle: true,
        title: const Text(
          'Students',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return ListView.builder(
              itemCount: state.studentProfile.length,
              itemBuilder: (context, index) {
                final profile = state.studentProfile[index];
                return StudentProfileCard(
                  profile: profile,
                  onEdit: () => _showStudentDialog(
                    context,
                    profile: profile,
                    isUpdate: true,
                  ),
                  onDelete: () {
                    BlocProvider.of<ProfileBloc>(context)
                        .add(DeleteProfile(profile.id));
                  },
                );
              },
            );
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.person_add_alt_1,
          size: 30,
          color: Colors.black,
        ),
        onPressed: () => _showStudentDialog(context, isUpdate: false),
      ),
    );
  }

  void _showStudentDialog(BuildContext context,
      {StudentProfile? profile, required bool isUpdate}) {
    final firstNameController =
        TextEditingController(text: profile?.firstName ?? '');
    final lastNameController =
        TextEditingController(text: profile?.lastName ?? '');
    final courseController = TextEditingController(text: profile?.course ?? '');

    // Set the initial values for editing, and check if the value is valid
    _isEnrolled = profile?.enrolled ?? false;
    String _selectedYearInDialog = _yearOptions.contains(profile?.year)
        ? profile!.year // Use profile's year if it's valid
        : _yearOptions.first; // Default to the first year if invalid or null

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext dialogContext, StateSetter setDialogState) {
            return AlertDialog(
              title: Text(isUpdate ? 'Update Student' : 'Create Student'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                    ),
                    TextField(
                      controller: lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                    ),
                    TextField(
                      controller: courseController,
                      decoration: const InputDecoration(labelText: 'Course'),
                    ),
                    DropdownButton<String>(
                      value: _selectedYearInDialog,
                      onChanged: (String? newValue) {
                        setDialogState(() {
                          _selectedYearInDialog = newValue!;
                        });
                      },
                      items: _yearOptions
                          .map<DropdownMenuItem<String>>((String year) {
                        return DropdownMenuItem<String>(
                          value: year,
                          child: Text(year),
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Enrolled'),
                        Switch(
                          value: _isEnrolled,
                          onChanged: (bool newValue) {
                            setDialogState(() {
                              _isEnrolled = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    final studentBloc = BlocProvider.of<ProfileBloc>(context);
                    final newStudent = StudentProfile(
                      id: isUpdate ? profile!.id : '',
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      course: courseController.text,
                      year:
                          _selectedYearInDialog, // Use the updated local variable
                      enrolled: _isEnrolled,
                    );
                    if (isUpdate) {
                      studentBloc.add(UpdateProfile(newStudent.id, newStudent));
                    } else {
                      studentBloc.add(CreateProfile(newStudent));
                    }
                    Navigator.pop(dialogContext);
                  },
                  child: Text(isUpdate ? 'Update' : 'Create'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
