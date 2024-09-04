import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/profile_bloc.dart';
import 'package:frontend/blocs/profile_event.dart';
import 'package:frontend/pages/profile_screen.dart';
import 'package:frontend/repository/profile_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student List',
      home: BlocProvider(
        create: (context) =>
            ProfileBloc(ProfileRepoImplement())..add(FetchProfiles()),
        child: ProfileScreen(),
      ),
    );
  }
}
