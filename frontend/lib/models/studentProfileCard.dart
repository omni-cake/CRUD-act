import 'package:flutter/material.dart';
import 'package:frontend/models/studentProfiles.dart';

class StudentProfileCard extends StatelessWidget {
  final StudentProfile profile;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const StudentProfileCard({
    Key? key,
    required this.profile,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width dynamically using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        // Adjust width to be 90% of the screen width
        width: screenWidth * 0.9,
        // Optionally, adjust the height dynamically or set a fixed value
        height: 120,
        child: Card(
          color: Colors.amber[600],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon(
                //   Icons.person,
                //   size: 40,
                //   color: Colors.blueGrey,
                // ),
                //Keep this in case you want photos
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${profile.firstName} ${profile.lastName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text('Course: ${profile.course}'),
                      Text('Year: ${profile.year}'),
                      Text('Enrolled: ${profile.enrolled ? "Yes" : "No"}'),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
