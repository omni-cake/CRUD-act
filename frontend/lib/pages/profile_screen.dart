import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/models/studentProfiles.dart';
import '../blocs/profile_bloc.dart';
import '../blocs/profile_event.dart';
import '../blocs/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

//TODO: SWITCH IS NOT WORKING

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedYear = 'First Year';
  bool _isEnrolled = false;
  final List<String> _yearOptions = [
    '',
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_add_alt_1,
              color: Colors.lightGreen,
            ),
            onPressed: () => _showStudentDialog(context, isUpdate: false),
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return ListView.builder(
              itemCount: state.studentProfile.length,
              itemBuilder: (context, index) {
                final profile = state.studentProfile[index];
                return ListTile(
                  title: Text('${profile.firstName} ${profile.lastName}'),
                  subtitle:
                      Text('Course: ${profile.course}, Year: ${profile.year}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                        onPressed: () => _showStudentDialog(context,
                            profile: profile, isUpdate: true),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () => BlocProvider.of<ProfileBloc>(context)
                            .add(DeleteProfile(profile.id)),
                      ),
                    ],
                  ),
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
    );
  }

  void _showStudentDialog(BuildContext context,
      {StudentProfile? profile, required bool isUpdate}) {
    final firstNameController =
        TextEditingController(text: profile?.firstName ?? '');
    final lastNameController =
        TextEditingController(text: profile?.lastName ?? '');
    final courseController = TextEditingController(text: profile?.course ?? '');

    _isEnrolled = profile?.enrolled ?? false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(isUpdate ? 'Update Student' : 'Create Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: courseController,
                decoration: InputDecoration(labelText: 'Course'),
              ),
              DropdownButton<String>(
                value: _selectedYear,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedYear = newValue!;
                  });
                },
                items:
                    _yearOptions.map<DropdownMenuItem<String>>((String year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Enrolled'),
                  Switch(
                    value: _isEnrolled,
                    onChanged: (bool newValue) {
                      setState(() {
                        _isEnrolled = newValue;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final studentBloc = BlocProvider.of<ProfileBloc>(context);
                final newStudent = StudentProfile(
                  id: isUpdate ? profile!.id : '',
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  course: courseController.text,
                  year: (_selectedYear),
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
  }
}
